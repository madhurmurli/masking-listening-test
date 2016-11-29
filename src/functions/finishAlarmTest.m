function success = finishAlarmTest(subject)

save([TestConfig.SubjectsFolder filesep subject.ID '.mat'], 'subject');

end