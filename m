Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4EEQlRb011621
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 10:26:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4EEQiMi014257
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 14:26:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4EEQipI014254 for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 14:26:44 GMT
Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4EEQiYf023406
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 10:26:44 -0400 (EDT)
Subject: Re: Updated Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
In-Reply-To: <1084489830.11135.80.camel@moss-huskies>
References: <1084489830.11135.80.camel@moss-huskies>
Content-Type: text/plain
Message-Id: <1084544798.17741.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 10:26:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-13 at 19:10, Howard Holm wrote:
> The SELinux web site <http://www.nsa.gov/selinux/> has been updated. The
> site includes a new release of the SELinux prototype. The current
> prototype and the experimental NFS code are now based on Linux kernel
> 2.6.6. Several races and kernel socket creation have been fixed and a
> runtime disable has been added. The old linux 2.4-based kernel patch has
> been ported to 2.4.26. The userland patches have been updated from
> Fedora Core 2 development. There are now man pages for libselinux. X
> server security classes and access vector definitions were added and
> many policy updates were made.

The sourceforge CVS tree has been updated for this release.  Please note
that this is the last planned release for the 2.4-based SELinux; a
snapshot of it will move to the historical versions page in future
releases and no further maintenance on it will be done.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
