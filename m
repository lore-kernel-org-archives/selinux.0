Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FHkCLa015285
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 13:46:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FHiWLY002890
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 17:44:32 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8FHiVsG002887
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 17:44:32 GMT
Subject: Re: Problem relabeling journalfile
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200309160251.25816.russell@coker.com.au>
References: <20030915145004.GB8988@vnl.com> <20030915152948.GC8988@vnl.com>
	 <1063640607.13311.156.camel@moss-spartans.epoch.ncsc.mil>
	 <200309160251.25816.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1063647964.13311.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 13:46:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 12:51, Russell Coker wrote:
> Do you think it would be beneficial to have a method of specifying rules that 
> apply relative to the root of a file system instead of to the root?
> 
> EG:
> FS/.journal
> FS/lost\+found
> FS/quota.user
> FS/quota.group
> 
> With the current operation of setfiles for completeness we have to add such 
> entries for every new mount point.  Having setfiles accept such a spec when 
> labeling an entire file system would be easy to code, and it wouldn't be 
> really difficult to manage the case of "setfiles -s".

You might be able to leverage the altroot support contributed by the
Hardened Gentoo developers to achieve the same effect without altering
the specification itself.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
