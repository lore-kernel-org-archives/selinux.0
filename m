Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA49GuWt005037
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 04:16:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA49GtKl011290
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 09:16:55 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hA49Gt5m011287 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 09:16:55 GMT
Date: Tue, 4 Nov 2003 09:16:50 +0000
From: Dale Amon <amon@vnl.com>
To: Dhruv Gami <dgami@uncc.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: selinux/2.6 on knoppix 3.3
Message-ID: <20031104091650.GM29928@vnl.com>
References: <3FA69267.40408@uncc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FA69267.40408@uncc.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 03, 2003 at 06:37:43PM +0100, Dhruv Gami wrote:
> hello everyone,
> 
> im a new user for selinux, and am trying to compile selinux for kernel 
> 2.6 on a knoppix 3.3 hdinstall (its basically a debian install).
> 
> I managed to compile the kernel (2.6), but only after removing certain 
> modules which were preventing compilation of the kernel.
> 
> Now when i tried to compile the selinux-usr packages, libselinux asks 
> for attr/xattr.h in some of the files, and i am unable to find libattr 
> for debian. i tried googling for it, but only found RPM packages for 
> libattr.
> 
> am i doing something wrong here ? am i supposed to install/use something 
> else ?
> 
> any help would be most appreciated.

It is libattr1 I believe, and is certainly available in
sid and sarge. woody also I believe but haven't gone
and checked. 

------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
