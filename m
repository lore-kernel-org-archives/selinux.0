Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72CcjrT011599
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:38:46 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72CcCXV015761
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:38:13 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040731163515.GR3378@lkcl.net>
References: 
	 <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
	 <20040729200502.GF9950@lkcl.net>
	 <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil>
	 <200407311143.19746.russell@coker.com.au>  <20040731163515.GR3378@lkcl.net>
Content-Type: text/plain
Message-Id: <1091450282.23449.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 08:38:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-31 at 12:35, Luke Kenneth Casson Leighton wrote:
>  what _you_ are saying, russell, is that instead of increasing the
>  permissions on the usage of tmpfs_t, is to mount a tmpfs mountpoint,
>  then run setfiles on its contents prior to use, such that it will
>  never be necessary to increase the permissions of tmpfs_t?
> 
>  because tmpfs_t is going to be temporary, you _have_ to do a setfiles
>  (or a restorecon on each individual file) _anyway_.

Each tmpfs instance should start life empty, as it is only a
memory-based filesystem anyway.  So you only have to worry about the
security context on the superblock and the security context on the root
directory.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
