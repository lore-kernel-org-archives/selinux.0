Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA24688
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 01:46:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA08084
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 05:44:52 GMT
Received: from mail.lemuria.org ([213.191.74.130])
        by jazzband.ncsc.mil  with ESMTP id FAA08080 for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 05:44:52 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 874B3BB8B
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 07:39:32 +0200 (CEST)
Date: Tue, 23 Apr 2002 07:43:22 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Message-ID: <20020423074322.C14880@lemuria.org>
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020422224503.C7C6744A5A@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020422224503.C7C6744A5A@lyta.coker.com.au>; from russell@coker.com.au on Tue, Apr 23, 2002 at 12:45:03AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 23, 2002 at 12:45:03AM +0200, Russell Coker wrote:
> /etc/lilo.conf will (on any properly configured system) contain a boot 
> password for the system, which is the best way of taking over a system 
> entirely without disassembling the hardware.  I think that this deserves a 
> different type to world-readable files such as /etc/passwd!
> 
> I think that the situation is similar for other boot loaders.

Physical access to the hardware always means you have lost (an
encrypted filesystem being the exception). Moreover, a lot of properly
configured systems do NOT have a boot password. If they are located in
a physical secure location, then coming up again after a crash or power
failure is more important than the off-chance that someone breaks into
the hosting center just to reboot and take over your machine.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
