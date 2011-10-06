Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p960Pixt018875
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 20:25:44 -0400
Received: from mout.perfora.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p960PhuQ005130
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 00:25:43 GMT
Message-ID: <4E8CF584.2080708@zeff.us>
Date: Wed, 05 Oct 2011 17:25:40 -0700
From: Joe Zeff <joe@zeff.us>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Puzzling SELinux problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running Fedora 14, fully updated, with SELinux.  Off and on I've had 
SELinux alerts from various WCG projects, but nothing major.  Recently, 
however, a badly written project started walking parts of /proc that it 
had no business in, causing large spews of alerts.  (BOINC runs in 
permissive mode, so nothing got blocked.)  I've dealt with that by 
unselecting the project.  However, at one point I accidentally clicked 
on the alert icon twice.  It came up, showing details of the alert then 
vanished, as a second sealert window came up, blank.  That is, no alerts 
to show.  Since then, I'm still getting alerts, but none of them show up 
in the troubleshooter window.  I've tried restarting auditd without 
effect and deleting the database.  Nothing works.  If anybody on this 
list knows what I can do to correct this, please let me know.  You can 
see what I'm describing at http://www.zeff.us/sealert.png

If this isn't the right list to put this on, please direct me to the 
right place.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
