Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9K8LmWt018440
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 04:21:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9K8LlmR026776
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 08:21:47 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
        by jazzband.ncsc.mil  with ESMTP id h9K8Ljjp026771 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 08:21:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
Date: Mon, 20 Oct 2003 10:21:10 +0200
References: <200310200148.15852.russell@coker.com.au>
In-Reply-To: <200310200148.15852.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200310201021.10773.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 19. Oktober 2003 17:48 schrieb Russell Coker:
> I've attached a patch for /sbin/init to load the policy and set
> enforcing mode.  Here's a quick summary of the algorithm:

That's great! Last Friday I had a lot of problems with the initrd 
(and my patched mkinitrd for SuSE) and I hope we don't need it in 
the future.

Could we parse the kernel command line to check the SELinux mode. 
I'm not sure if a general start in the enforcing mode a good idea.

Carsten




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
