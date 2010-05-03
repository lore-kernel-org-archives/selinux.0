Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o434sUOg023151
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 00:54:34 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o434tZW1023188
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 04:55:35 GMT
Received: by pwj10 with SMTP id 10so1103477pwj.12
        for <selinux@tycho.nsa.gov>; Sun, 02 May 2010 21:54:28 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 May 2010 21:54:27 -0700
Message-ID: <p2vdd18b0c31005022154obbc1db15s4e01c5821bf7baa2@mail.gmail.com>
Subject: /etc/initscript breaks SELinux
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: tresys <refpolicy@oss1.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been racking my brain for the last few days on
this one, and seem(for the life of me), have no solution.

at first thought this was opensuse specific, but it's not
i.g. my cblfs systems hit this as well(if not all systems at that).

when adding /etc/initscript somehow SELinux can't figure how to
transistion with the whole SHELL -c thing.

under init.c #800(sysvinit-2.85)
the code is this:

 /* See if there is an "initscript" (except in single user mode). */
  if (access(INITSCRIPT, R_OK) == 0 && runlevel != 'S') {
	/* Build command line using "initscript" */
	args[1] = SHELL;
	args[2] = INITSCRIPT;
	args[3] = ch->id;
	args[4] = ch->rlevel;
	args[5] = "unknown";
	for(f = 0; actions[f].name; f++) {
		if (ch->action == actions[f].act) {
			args[5] = actions[f].name;
			break;
		}
	}


any ideas why SELinux gets confused with this, and
doesn't want to transistion?


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
