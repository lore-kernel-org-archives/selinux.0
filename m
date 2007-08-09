Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79Hswck025274
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:58 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79Hsvk4018012
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:54:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hsm9R024375
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:48 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hsi83002549
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:45 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79HsioG020682
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:54:44 +0100
Subject: Re: [PATCH 11/14] CacheFiles: Permit an inode's security ID to be
	obtained [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <162335.27499.qm@web36605.mail.mud.yahoo.com>
References: <162335.27499.qm@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 13:22:04 -0400
Message-Id: <1186680124.6916.624.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 10:07 -0700, Casey Schaufler wrote:
> --- David Howells <dhowells@redhat.com> wrote:
> 
> > Permit an inode's security ID to be obtained by the CacheFiles module.  This
> > is
> > then used as the SID with which files and directories will be created in the
> > cache.
> 
> This is SELinux specific functionality. It should not be an LSM
> interface. 

Odd, you proposed exactly the same hook (aside from naming convention
and secid as argument vs. as retval) in recent postings on linux-audit
and selinux list for use by the audit system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
