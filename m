Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8QD6VsJ000050
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 09:06:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8QD4kZt014504
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 13:04:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8QD4jM3014501
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 13:04:46 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8QD6TRL019145
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 09:06:29 -0400 (EDT)
Subject: sourceforge selinux CVS tree updated
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1064581589.5099.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 26 Sep 2003 09:06:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The sourceforge selinux CVS tree has been updated to include
various updates that have been posted since the last public release
(including a number of contributed patches). 

If you have developer access, you can checkout a copy by doing the
following, replacing USERNAME with your sourceforge account name:
  export CVS_RSH=ssh
  cvs -z3 -d:ext:USERNAME@cvs.sf.net:/cvsroot/selinux co nsa

If not, you can checkout a copy by doing the following:
  cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/selinux login
	(hit enter when prompted for a password)
  cvs -z3 -d:pserver:anonymous@cvs.sf.net:/cvsroot/selinux co nsa
  
If you don't have developer access but are a regular contributor, you can
send one of the project admins a note requesting developer access with your 
sourceforge account name.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
