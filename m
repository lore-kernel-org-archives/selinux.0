Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SFwKRb005609
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 10:58:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0SFvs1W021313
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:58:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0SFumVC021022 for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:56:48 GMT
Subject: Re: libselinux/getpeercon/compiler warning on 64bit Archs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040128094142.GA24926@suse.de>
References: <20040128094142.GA24926@suse.de>
Content-Type: text/plain
Message-Id: <1075305340.19427.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 10:55:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 04:41, Thorsten Kukuk wrote:
> Hi,
> 
> On 64bit architectures, I get the follwoing compiler warnings:
> 
> getpeercon.c:26: warning: passing arg 5 of `getsockopt' from incompatible pointer type
> getpeercon.c:36: warning: passing arg 5 of `getsockopt' from incompatible pointer type
> 
> The fix is simple, the variable "size" in getpeercon() should be from
> type "socklen_t", not "ssize_t".

Thanks, we'll fix this.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
