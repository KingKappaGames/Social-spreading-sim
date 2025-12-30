function script_getRumorAllegiance(subjectIndex) {
	if(subjectIndex == E_subjects.empire) {
		return E_allegiance.royal;
	} else if(subjectIndex == E_subjects.microPlastics) {
		return E_allegiance.common;
	} else if(subjectIndex == E_subjects.cancer) {
		return E_allegiance.neutral;
	} else if(subjectIndex == E_subjects.globalWarming) {
		return E_allegiance.wild;
	} else if(subjectIndex == E_subjects.famine) {
		return E_allegiance.common;
	}
}