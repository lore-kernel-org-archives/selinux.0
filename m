Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96FOEWt005655
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 11:24:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h96FMq7f012036
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:24:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h96EKXRn008669 for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 14:21:53 GMT
Subject: Re: Updated Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031004114020.GA7845@markus.schuldei.org>
References: <1065114741.27477.3042.camel@moss-huskies>
	 <20031003064750.GA4555@markus.schuldei.org>
	 <1065188703.4080.114.camel@moss-spartans.epoch.ncsc.mil>
	 <20031004114020.GA7845@markus.schuldei.org>
Content-Type: text/plain
Message-Id: <1065450015.3919.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Oct 2003 10:20:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-04 at 07:40, Andreas Schuldei wrote:
> you mention the xattr api. can this tar be uses to restore
> systems or parts of a system, bridging the 2.4 -> 2.6 switch? Or
> is it only good for the version of selinux the backup was created
> with?

The star program only works with extended attributes and (with the
SELinux patch) with the new SELinux API.  The old SELinux API was never
supported by star.  Also, just to be clear, the API and implementation
changes to SELinux (including the use of xattr) were back ported to
Linux 2.4, so there is no difference in API or xattr usage between the
current 2.4-based and 2.6-based SELinux.  The old SELinux has been moved
to the historical versions page and is no longer maintained, at least
not by us.

Upgrading an existing system from the old SELinux to the new SELinux
seamlessly is complicated; see the earlier discussions on the list
regarding it, e.g.
http://marc.theaimsgroup.com/?l=selinux&m=106156668426416&w=2

> i did not find the rpm (or srpm or tar) file for star on the
> download page. what is the url to it?

You can obtain any of the SRPMS for the patched daemons and utilities
from http://www.nsa.gov/selinux/SRPMS.  Sorry, we'll add an explicit
link for the star patch and SRPM to the download page next time.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
