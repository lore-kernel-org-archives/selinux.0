Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBIGOsEd012922
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 11:24:54 -0500
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBIGOrr2013886
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 16:24:53 GMT
Received: by nz-out-0506.google.com with SMTP id i1so1258324nzh.39
        for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 08:24:38 -0800 (PST)
Message-ID: <4767F243.3090509@gmail.com>
Date: Tue, 18 Dec 2007 10:16:03 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: MLS and default file contexts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As best I can tell the current implementation requires a context to have 
a level or range to be valid in an fc file. However there a cases where 
I'd prefer that files be created with a given context but at the level 
of the creating process. Is there a way to do specify this behavior in 
an fc file?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
