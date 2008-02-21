Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1LCVVIw006877
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 07:31:31 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1LCVTGd025121
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 12:31:30 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200802201907.40406.phillips@phunq.net>
References: <200802201907.40406.phillips@phunq.net> <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
To: Daniel Phillips <phillips@phunq.net>
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        casey@schaufler-ca.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/37] Permit filesystem local caching
Date: Thu, 21 Feb 2008 12:31:12 +0000
Message-ID: <19566.1203597072@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel Phillips <phillips@phunq.net> wrote:

> > These patches add local caching for network filesystems such as NFS.
> 
> Have you got before/after benchmark results?

I need to get a new hard drive for my test machine before I can go and get
some more up to date benchmark results.  It does seem, however, that the I/O
error handling capabilities of FS-Cache work properly:-)

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
