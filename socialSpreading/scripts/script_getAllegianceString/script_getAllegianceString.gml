function script_getAllegianceString(allegianceIndex) {
	if(allegianceIndex == E_allegiance.royal) {
		return "royal";
	} else if(allegianceIndex == E_allegiance.bandit) {
		return "bandit";
	} else if(allegianceIndex == E_allegiance.common) {
		return "common";
	} else if(allegianceIndex == E_allegiance.wild) {
		return "wild";
	} else if(allegianceIndex == E_allegiance.neutral) {
		return "neutral";
	} else if(allegianceIndex == E_allegiance.fightAllExceptSelf) {
		return "fight all except self";
	} else if(allegianceIndex == E_allegiance.fightAll) {
		return "fight all";
	}
	
	return "did not find allegiance"
}