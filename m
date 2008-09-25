Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8PF8b0q031854
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 11:08:37 -0400
Received: from mail-gx0-f12.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8PF7dPq026109
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 15:07:39 GMT
Received: by gxk5 with SMTP id 5so7282853gxk.18
        for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 08:08:37 -0700 (PDT)
Message-ID: <cadfc0e40809250808q1dcfcd94n2c2fa496a485b790@mail.gmail.com>
Date: Thu, 25 Sep 2008 10:08:36 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: checkmodule: duplicate declaration of type/attribute problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The attribute in question is inside a gen_require of a template and I
have looked at the tmp file to verify that there is only one
declaration. Is this a misleading error message or a compiler bug? Any
suggestions on how to deal with this problem?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
