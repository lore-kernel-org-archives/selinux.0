Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA18433
	for <selinux@tycho.nsa.gov>; Sat, 23 Dec 2000 19:24:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA28570
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 00:23:39 GMT
Received: from penguincomputing.com ([209.24.233.229])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with SMTP id AAA28566
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 00:23:39 GMT
Date: Sat, 23 Dec 2000 16:24:01 -0800
From: Jeremiah Johnson <jjohnson@penguincomputing.com>
To: selinux@tycho.nsa.gov
Subject: Re: Does this address the setuid() bug?
Message-ID: <20001223162401.A21054@mailserver.penguincomputing.com>
References: <3A44F97D.9E908172@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A44F97D.9E908172@worldnet.att.net>; from buckyG@worldnet.att.net on Sat, Dec 23, 2000 at 12:14:05PM -0700
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Technically it would inherit any bugs fixed in whatever the newest kernel is, unless they where bugs introduced after 2.2.12 and before 2.2.18.  There is also a patch out for 2.2.17 though, so you could use that.

Jeremiah Johnson
Linux Security Analyst
Penguin Computing

On Sat, Dec 23, 2000 at 12:14:05PM -0700, Bucky Goldstein wrote:
> Seeing as selinix is based on the 2.2.12 kernel, is it affected by the
> setuid() bug that plagued kernel versions < 2.2.15 ?
> 
> Sorry if this question has been asked before.
> 
> TIA,
> 
> Bucky Goldstein
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
