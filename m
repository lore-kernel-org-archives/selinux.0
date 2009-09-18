Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8IJtleB009765
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 15:55:47 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8IJvDGJ012491
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 19:57:13 GMT
Message-ID: <4AB3E5BF.2050806@manicmethod.com>
Date: Fri, 18 Sep 2009 15:55:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Caleb Case <ccase@tresys.com>, James Carter <jwcart2@epoch.ncsc.mil>
Subject: CIL infrastructure repo and talks at Summit/LPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've just put up a git repository for the cil (common intermediary 
language) infrastructure work on oss.tresys.com.

You can clone it by running:
# git clone http://oss.tresys.com/git/selinux-cil.git

We'll be committing to this tree as we get pieces of the new 
infrastructure done. The repo currently has 4 commits outside of the 
upstream repo that remove all the records and databases from 
libsemanage, as well as removing any linkage to libsepol in libsemanage.

If you have no idea what I've been talking about and you are going to be 
at the Linux Plumbers Conference and LinuxCon you can come to the 
SELinux developers summit[1] and join in on the discussion of the new 
infrastructure and/or come to James Carter's talk during LPC itself[2].

[1] http://selinuxproject.org/page/Developer_Summit_2009
[2] http://linuxplumbersconf.org/ocw/proposals/56

Though these first 4 commits didn't go to the mailing list (primarily 
due to size) the patches from here on will be posted to the list. That 
will give everyone an opportunity to see what is going on in the 
infrastructure before it is all done and we want to switch over.

Thanks and I hope to see you at the summit and SELinux talks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
