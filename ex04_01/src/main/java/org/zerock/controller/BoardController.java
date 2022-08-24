package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/board/*")
@Controller
@Log4j
public class BoardController {

	@Autowired
	private BoardService service;

	@GetMapping("/list")
	public void getList(Criteria cri, Model model, ModelMap map) {
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new PageDTO(cri, 70));
		int total = service.getTotal(cri);
		// model.addAttribute("pageMaker", new PageDTO(cri, total));

		// ModelMap 사용하면 길게 작성할 필요없이 가독성도 좋아진다
		map.put("pageMaker", new PageDTO(cri, total));
	}

	// @ModelAttribute : 자동으로 Model에 데이터를 지정한 이름으로 담아줌 / 파라미터로 지정하면 @ModelAttribute를
	// 사용하지 않아도 되지만 명시적으로 이름을 지정하기 위해서 사용
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
	}

	@GetMapping("/register")
	public void register() {

	}

	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("========================================");
		log.info("register: " + vo);
		if (vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("========================================");
		service.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());

		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if (service.remove(bno)) {
			// delete attach Files
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}

	@PostMapping("/modify")
	public String modify(BoardVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.modify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files..........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error " + e.getMessage()); 
			}
		});
	}
}
