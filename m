Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4K875I4008295
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 04:07:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4K874tV014954
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 08:07:05 GMT
Received: from narya.grin.hu (Narya.grin.hu [195.38.113.130])
        by jazzband.ncsc.mil  with ESMTP id h4K873al014950 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 08:07:04 GMT
Date: Tue, 20 May 2003 10:06:52 +0200
From: Peter Gervai <grin@tolna.net>
To: Torsten Knodt <tk-selinux@datas-world.de>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy for exim and/ or tiger?
Message-ID: <20030520080652.GW32563@narya.grin.hu>
Reply-To: grin@tolna.net
References: <200305152349.28038.tk-selinux@datas-world.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305152349.28038.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

On Thu, May 15, 2003 at 11:49:26PM +0200, Torsten Knodt wrote:

> has someone a policy for the exim mta and/ or the tiger script?

I have a still evolving exim policy at

http://narya.grin.hu/selinux/policy/

as selinux0516.tgz and selinux/ (they're the same). Unfortunately some of
the very useful advices and modifications Russel did tell me I was not able
to use without severe side effects, probably mta.te and exim.te still needs
a definite amount of polishment. 

In the current state it works for me(tm), and I have practised wishful
thinking about it being secure. :-)

Still I'd be glad to hear comments and advices and I try to merge them up to
the point when they make it not to work, when I have to stop merging. :-/

I have policy for pine, I mean, it's something like a policy but looks like
a horrible rape on selinux for me, since it contains plenty of horrible
permissions granted. I wonder whether it can be made working without
these...

I changed the dovecot and maradns policies a bit, but I'm still not
satisfied. Due to the time constraints I won't promise The Perfect Versions
available too soon. 

Peter

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
