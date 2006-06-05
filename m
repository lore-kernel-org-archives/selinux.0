Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k55FB47F032196
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 11:11:05 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k55FB3hb025910
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 15:11:03 GMT
Received: by ug-out-1314.google.com with SMTP id y2so1411865uge
        for <selinux@tycho.nsa.gov>; Mon, 05 Jun 2006 08:11:02 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Switch between struct security_context_t and context_t
Date: Mon, 5 Jun 2006 17:10:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <44844985.754de417.4f4c.ffffbae9@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm writing some simple program that uses SELinux Api but I don't find any
function that transform a security_context_t variable in context_t. It's
possible to force cast but if exists a function that performance this
operation is better...
Anyone can give me an help?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
