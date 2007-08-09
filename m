Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79HsdxU025240
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79HsbVe011710
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:54:37 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hsa7F024281
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:36 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79HsanF002474
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:36 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79HsZTf020665
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:54:35 +0100
Date: Thu, 9 Aug 2007 10:07:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 11/14] CacheFiles: Permit an inode's security ID to be obtained [try #2]
To: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070809160535.17906.59852.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <162335.27499.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Permit an inode's security ID to be obtained by the CacheFiles module.  This
> is
> then used as the SID with which files and directories will be created in the
> cache.

This is SELinux specific functionality. It should not be an LSM
interface. 

Casey Schaufler
casey@schaufler-ca.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
