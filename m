Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JNIe6R019710
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 18:18:40 -0500
Received: from web36603.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JNIZAh012057
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 23:18:35 GMT
Date: Tue, 19 Feb 2008 15:18:10 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: NFS/LSM: allow NFS to control all of its own mount options
To: Christoph Hellwig <hch@infradead.org>, Eric Paris <eparis@redhat.com>
Cc: linux-nfs@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, steved@redhat.com,
        jlayton@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org,
        casey@schaufler-ca.com, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <20080219222408.GB10656@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <84435.4520.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Christoph Hellwig <hch@infradead.org> wrote:

> Please don't introduce a special case for just nfs.  All filesystems
> should control their mount options, so please provide some library
> helpers for context= handling and move it into all filesystems that
> can support selinux.

Smack has options that are filesystem independent
(smackfsdef= smackfsroot= smackfsfloor= smackfshat=)
instead of the context= SELinux seems happy with.
Since there is no reason that a file system even
really needs to know what these values are it would
be completely unreasonable to teach every filesystem
about them. The information is completely controlled
and used by the LSM.

Of course, we could use something other than mount options
(vfsctl? sorry - only kidding) to set the LSM specific
information, and that might be the right approach.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
