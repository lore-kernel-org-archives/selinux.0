Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26089
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 12:01:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PH1II19290
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 17:01:18 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1PH1If19286 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 17:01:18 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Frank Mayer'" <mayerf@tresys.com>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: convention for disabled/unused policy modules
Date: Tue, 25 Feb 2003 12:00:12 -0500
Message-ID: <002001c2dcef$633509f0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <001501c2dcd8$0b161b40$6600a8c0@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> So to avoid a compatibility problem,  I'd like to
> suggest the use of the "Unused" directory as a convention 

Someone noted to me that we really should use "unused" rather than
"Unused".  I agree; I'll update our tool to try :unused" first and only
then to try "Unused" for backwards compatibility.  Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
