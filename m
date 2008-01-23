Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0NHL59e021703
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 12:21:05 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0NHL4bP025721
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 17:21:04 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080123004459.15602.45031.stgit@warthog.procyon.org.uk>
References: <20080123004459.15602.45031.stgit@warthog.procyon.org.uk> <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 14/27] FS-Cache: Recruit a couple of page flags for cache management
Date: Wed, 23 Jan 2008 17:20:09 +0000
Message-ID: <11099.1201108809@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

>  (2) PG_fscache_write (PG_owner_priv_2)
> 
>      The marked page is being written to the local cache.  The page may not be
>      modified whilst this is in progress.

Oops.  wait_on_page_owner_priv_2() should use PG_owner_priv_2 rather than
PG_private_2.  I'll release a new patchset shortly.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
