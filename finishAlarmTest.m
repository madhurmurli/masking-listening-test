function success = finishAlarmTest(subject)

success = save([TestConfig.SubjectsFolder filesep subject.ID '.mat'], 'subject');

end