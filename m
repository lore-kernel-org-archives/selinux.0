Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8TCQBsJ011036
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 08:26:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8TCONZt000458
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 12:24:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8TCOMM3000446
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 12:24:22 GMT
Subject: Re: selinux and 64 bit hardware
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>, Howard Holm <hdholm@epoch.ncsc.mil>,
   James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030927173909.GB3936@hydra.joerghoh.de>
References: <20030927173909.GB3936@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1064838357.10464.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 08:25:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-27 at 13:39, Joerg Hoh wrote:
> Hi 
> 
> I have an alpha machine (64bit) right next to me running linux 2.6.0test5. 
> I'd like to do some tests with selinux on this machine, but selinux doesn't 
> work correctly. 
> 
> I've done some research at the code and detected that, some parts are _not_
> portable (conversions from pointer to int, which only works on 32 bit
> architectures, and so on).
> 
> Is this intentional? Are some parts based on assumptions, which are only
> true on 32bit architectures? Are patches welcome to achieve a better 64 bit
> compatibility?

Several fixes for 64 bit architectures were included in 2.6.0-test5
based on feedback on the linux-kernel mailing list.  If you have
encountered further problems, we'd certainly like to hear about them.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
