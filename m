Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24101
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 17:19:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA04712
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 21:17:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA04708 for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 21:17:39 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tim Bird <tim@bird.org>, linux-security-module@wirex.com
Subject: Re: Any assured channel work for Linux
Date: Mon, 16 Sep 2002 23:19:12 +0200
References: <3D85F3D9.D06AAC4A@bird.org>
In-Reply-To: <3D85F3D9.D06AAC4A@bird.org>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209162319.12992.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Sep 2002 17:08, Tim Bird wrote:
> I've looked around at various projects, but don't see
> anything that directly addresses intra-machine
> assured channel IPCs.  I know that the MAC capabilities
> provided by LSM let me constrain access to things like
> /dev/mem, and to operations performed on pipes sockets.
> But would LSM hooks allow one process to
> authenticate another process at the other end of a
> standard IPC like a pipe or a shared memory segment?

SE Linux (which is based on LSM) restricts access to shared memory regions, 
unix domain sockets, pipes, etc.  In SE Linux there are system calls to 
determine who is connecting to you by a Unix domain socket and work is in 
progress on extending the same functionality to TCP sockets over the network.

It seems that SE Linux does everything you want.

Or am I misunderstanding your question?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
