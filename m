Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9IVXIi014690
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:31:33 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9IVaEj003771
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:31:36 GMT
Subject: Re: patch: policy for powernowd
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20041209173555.GE5074@jmh.mhn.de>
References: <20041209173555.GE5074@jmh.mhn.de>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 13:31:16 -0500
Message-Id: <1102617077.2582.3.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 18:35 +0100, Thomas Bleher wrote:
> Attached is policy for powernowd.

This is just a slight variation of cpuspeed.te.  Does powernowd really
need its own policy?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
