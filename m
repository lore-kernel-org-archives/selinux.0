Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DLtkWt015622
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 17:55:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9DLte0p029183
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 21:55:40 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9DLtcr7029180
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 21:55:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux@tycho.nsa.gov
Subject: Re: avc: denied messages
Date: Tue, 14 Oct 2003 07:55:36 +1000
References: <3F8AEBBE.7070602@ipen.br>
In-Reply-To: <3F8AEBBE.7070602@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310140755.36112.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Oct 2003 04:15, Carlos Anísio Monteiro wrote:
> When system boot process is running up a lot of messages "avc: denied"
> are displayed, in permissive mode e enforcing mode. In permissive mode,
> for all the messages "avc: denied" the boot process is completed and the
> login prompt is showed. However, in enforcing mode, it displayed the
> messages "avc: denied", but also displayed others messages: "INIT: Id
> "runlevel number" respawning too fast: disable for 5 minutes", "INIT: no
> more processes left in this runlevel"; and stop the boot process.
> Please, how I resolve this ?

To answer this question we need to know the exact messages in question, both 
the AVC messages and which ID init says is respawning too fast.

> PS. I appended the line "/.journal <<none>>" in the file_context file,
> because one error message is displayed when compiling the rules.

What error?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
