Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72DArrT011906
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 09:10:53 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72DApKV009709
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 13:10:52 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801120357.GG7384@lkcl.net>
References: 
	 <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
	 <200407311143.19746.russell@coker.com.au> <20040731163515.GR3378@lkcl.net>
	 <200408012031.37581.russell@coker.com.au>  <20040801120357.GG7384@lkcl.net>
Content-Type: text/plain
Message-Id: <1091452209.23449.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 09:10:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-01 at 08:03, Luke Kenneth Casson Leighton wrote:
>  i can just change, in /etc/selinux/src/fs_use, the line
>  that says something like fs_trans shm .... tmpfs_t to
>  say tmp_t?

This merely changes the default labeling for all tmpfs mounts, so it
will affect the kernel internal mount for shmem, any tmpfs mount you
create on /tmp, /dev, etc.  That is only adequate if you are willing to
apply the same policy to all tmpfs mounts, not generally acceptable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
