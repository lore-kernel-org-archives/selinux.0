Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97KY6Wt014692
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 16:34:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97KXx7f021837
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 20:34:05 GMT
Subject: Re: [selinux] init
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310080111.50210.russell@coker.com.au>
References: <200310080111.50210.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-2
Date: 07 Oct 2003 22:27:02 +0200
Message-Id: <1065558422.7696.106.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2003-10-07, k keltezéssel Russell Coker ezt írta:
> We have been having a discussion of initrd etc.  There is some great 
> opposition to modifying the initrd because it's something that no-one wants 

Yepyep.

> An idea that came up was to modify init so that it would do the following:
> 1) Check if /selinux is mounted.  If yes then go to 5.
> 2) mount /selinux, if mount fails then go to 5.
> 3) Load the policy from /etc/selinux/policy.xx.  If load fails then umount
> /selinux, display a message, and go to 5.
> 4) Exec itself to change domain from kernel_t to init_t.
> 5) Perform usual init functions.

Will Miquel like the idea? I hope so.

I would vote for 5 being
< 5) if policy isn't loaded and we don't have [some indication that we
do not insist on selinux], halt the system with an appropriate message.

The indication could be that there is no selinux support in the kernel,
or some boot option.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
