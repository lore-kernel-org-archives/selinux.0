Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HCxGrT016264
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 08:59:16 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HCw2xh001933
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 12:58:03 GMT
Subject: Re: kernel oops
From: Erich Schubert <erich@debian.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041017120245.GB2537@jmh.mhn.de>
References: <20041017120245.GB2537@jmh.mhn.de>
Content-Type: text/plain
Date: Sun, 17 Oct 2004 14:59:08 +0200
Message-Id: <1098017948.28183.18.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Thomas,

> happened on a system with loaded nvidia binary driver. Nevertheless,

> Call Trace:
>  [<c0257281>] validate_class+0x91/0x140
>  [<c0257180>] validate_perm+0x0/0x70
>  [<c0252b44>] hashtab_map+0x44/0x70
>  [<c02575e5>] security_load_policy+0x125/0x330
>  [<c02571f0>] validate_class+0x0/0x140

>  [<f0f656f6>] _nv001140rm+0x10a/0x118 [nvidia]

Not just with a loaded nvidia driver, but with nvidia in the call trace.
(I'm no kernel expert at all. it looks a bit like an interrupt occured
while transferring the policy to kernel space, that got handled by the
nvidia driver. but that is just a guess.)

>  [<c0108899>] handle_IRQ_event+0x49/0x80
>  [<c0108cfa>] do_IRQ+0xea/0x1a0
>  [<c0106d48>] common_interrupt+0x18/0x20
>  [<c0277f92>] __copy_from_user_ll+0x42/0x80

Does it happen frequently? If so, try without preempt enabled.

P.S. we should to exchange GPG keys; i'm at IFI, too, and i've got a
strongly connected key. Although i havn't met rjc or colin yet in person
i do only have a path distance of 2 to them, often with multiple links
(well, the debian crowd loves keysigning...)

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
      Go away or i'll replace you with a very small shell script.     //\
  In unseren Freunden suchen wir, was uns fehlt. --- Thornton Wilder  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
