Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19584
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:12:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA06619
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:12:08 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id PAA06613
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:12:07 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: user tool, updated apol
Date: Fri, 24 May 2002 11:15:47 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIGENLKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've finished with version 0.1 of our user manager tool for SE Linux
(seuser).  We've also added a couple of features to apol, and fixed some
bugs (version 0.4.1).  Starting with this release, we're now packaging the
tools in a single tar file (setools), with libraries separated, and an
extended TK wish program (awish) for those who want to try to write their
own GUIs using our library.  As always, we're distributing as source only.

You can find the source at http://www.tresys.com/selinux.html, along with
some preview screenshots.  Please direct comments/questions to
selinux@tresys.com.

Regards,

Frank Mayer


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
