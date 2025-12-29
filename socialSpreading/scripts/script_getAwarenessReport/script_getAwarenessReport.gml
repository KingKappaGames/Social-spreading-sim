function script_getAwarenessReport(subject, rumorStruct) {
	var _pub = rumorStruct.publicity;
	var _pubMax = rumorStruct.publicityMax;
	
	var _report = "";
	
	if(subject == E_subjects.empire) {
		if(_pub < .4) {
			_report += $"This cities knowledge about the empire is {_pub * 100}%. The damn, godless heathens.";
		} else if(_pub < .8) {
			_report += $"This cities knowledge about the empire is {_pub * 100}%. Business as usual, I suppose.";
		} else {
			_report += $"This cities knowledge about the empire is {_pub * 100}%. Certainly up to date, aren't they?";
		}
		
		_report += "\n";
		
		if(_pubMax < .4) {
			_report += $"This cities best info about the empire is {_pubMax * 100}%. A travesty is what it is.";
		} else if(_pubMax < .8) {
			_report += $"This cities best info about the empire is {_pubMax * 100}%. Somebody should get them some damn news papers.";
		} else {
			_report += $"This cities best info about the empire is {_pubMax * 100}%. No excuses, now.";
		}
	} else if(subject == E_subjects.microPlastics) {
		if(_pub < .4) {
			_report += $"This cities knowledge about microplastics is {_pub * 100}%. They'll be swimming in them with this foresight.";
		} else if(_pub < .8) {
			_report += $"This cities knowledge about microplastics is {_pub * 100}%. Nobodies getting an award for {_pub * 100}%, damnit!";
		} else {
			_report += $"This cities knowledge about microplastics is {_pub * 100}%. I heard they made the stuff illegal a decade ago!";
		}
		
		_report += "\n";
		
		if(_pubMax < .4) {
			_report += $"This cities best info about microplastics is {_pubMax * 100}%. A travesty is what it is.";
		} else if(_pubMax < .8) {
			_report += $"This cities best info about microplastics is {_pubMax * 100}%. Somebody should get them some damn news papers.";
		} else {
			_report += $"This cities best info about microplastics is {_pubMax * 100}%. No excuses, now.";
		}
	} else if(subject == E_subjects.cancer) {
		if(_pub < .4) {
			_report += $"This cities knowledge about cancer is {_pub * 100}%. Knowing is half the battle. Oh, cancer, you say? Hm, well, ignorance is bliss after all...";
		} else if(_pub < .8) {
			_report += $"This cities knowledge about cancer is {_pub * 100}%. My sons and daughters will know the name, cancer... Maybe, though, their children might forget.";
		} else {
			_report += $"This cities knowledge about cancer is {_pub * 100}%. What defense can be mounted against oneself; that which cannot be fought or beaten. The answer will be found.";
		}
		
		_report += "\n";
		
		if(_pubMax < .4) {
			_report += $"This cities best info about cancer is {_pubMax * 100}%. A travesty is what it is.";
		} else if(_pubMax < .8) {
			_report += $"This cities best info about cancer is {_pubMax * 100}%. Somebody should get them some damn news papers.";
		} else {
			_report += $"This cities best info about cancer is {_pubMax * 100}%. No excuses, now.";
		}
	} else if(subject == E_subjects.globalWarming) {
		if(_pub < .4) {
			_report += $"This cities knowledge about global warming is {_pub * 100}%. A reasonable number for a society of circles in empty space. Still, terrible.";
		} else if(_pub < .8) {
			_report += $"This cities knowledge about global warming is {_pub * 100}%. Fine enough, science wasn't their strong suit.";
		} else {
			_report += $"This cities knowledge about global warming is {_pub * 100}%. Studious little things, aren't they? Problems will fall because they caught their eye.";
		}
		
		_report += "\n";
		
		if(_pubMax < .4) {
			_report += $"This cities best info about global warming is {_pubMax * 100}%. As with a tap of the escape, a world burns and is gone, no one left to regret it.";
		} else if(_pubMax < .8) {
			_report += $"This cities best info about global warming is {_pubMax * 100}%. Somebody should get them some news papers.";
		} else {
			_report += $"This cities best info about global warming is {_pubMax * 100}%. They intend to answer the question of whether an individual can really change the world, or a million individuals.";
		}
	} else if(subject == E_subjects.famine) {
		if(_pub < .4) {
			_report += $"This cities knowledge about famine is {_pub * 100}%. Generations slip below the surface, like little sparks in the night sky. Not destroyed but simply vanished.";
		} else if(_pub < .8) {
			_report += $"This cities knowledge about famine is {_pub * 100}%. What more must be learned about hunger? Thinking is hard work, and requires food. The world is not enough.";
		} else {
			_report += $"This cities knowledge about famine is {_pub * 100}%. From the very beginning man has fought to preserve itself, and with us, the end will dawn on famine.";
		}
		
		_report += "\n";
		
		if(_pubMax < .4) {
			_report += $"This cities best info about famine is {_pubMax * 100}%. A travesty is what it is.";
		} else if(_pubMax < .8) {
			_report += $"This cities best info about famine is {_pubMax * 100}%. Somebody should get them some damn news papers.";
		} else {
			_report += $"This cities best info about famine is {_pubMax * 100}%. No excuses, now.";
		}
	}
	
	return _report;
}