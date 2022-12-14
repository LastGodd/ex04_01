package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Autowired
	private BoardAttachMapper attachMapper;

//	// 매분 0초마다 한 번씩 실행되도록 저장
//	@Scheduled(cron="0 * * * * *")
//	public void checkFiles() throws Exception {
//		log.warn("File Check Task run.....");
//		log.warn("==================================================");
//	}

	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}

	// 매일 새벽 2시에 DB에 기록되지 않은 폴더의 파일을 삭제시킴
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception {
		log.warn("File Check Task run.....");
		log.warn(new Date());

		// file list in database
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();

		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());

		// image file has thumbNail file
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));

		log.warn("==================================================");
		fileListPaths.forEach(p -> log.warn(p));

		// file in yesterday directory
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		log.warn("==================================================");
		for (File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}

}
