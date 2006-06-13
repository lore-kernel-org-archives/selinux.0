Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DF8hBp029383
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 11:08:43 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5DF8gCb004603
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 15:08:42 GMT
Received: by ug-out-1314.google.com with SMTP id y2so2796053uge
        for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 08:08:41 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: PaX and SELinux
Date: Tue, 13 Jun 2006 17:08:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <448ed4f8.6359f250.6649.5416@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found a PaX security class in refpolicy but I have a little doubt..If I
compile a kernel with SELinux, at the same time the kernel has installed PaX
system (pax.grsecurity.net)? 
So I can set pax flag using this security class?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
