From: David Howells <dhowells@redhat.com>
In-Reply-To: <1200424508.9669.63.camel@moss-spartans.epoch.ncsc.mil>
References: <1200424508.9669.63.camel@moss-spartans.epoch.ncsc.mil> <286481.40953.qm@web36613.mail.mud.yahoo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Daniel J Walsh <dwalsh@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Tue, 15 Jan 2008 21:55:10 +0000
Message-ID: <6778.1200434110@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> The cache files are created by the cachefiles kernel module, not by the
> userspace daemon, and the userspace daemon doesn't need to directly
> read/write them at all

That is correct.

> (but I think it does need to be able to unlink them?).

Indeed.

> The userspace daemon merely identifies the directory where the cache should
> live as part of configuring the cache when enabling it.

That is the way it currently works, yes.
 
> Hence, it is fine to use a fixed label for the cache files (systemhigh
> in a MLS world), and to let the directory's label serve as the basis for
> it.

That is what I currently do.  SELinux rules are provided to grant the
appropriate file accesses to the override label used by the kernel module, so
that it can't go and stamp on files with the wrong label.

> Only the cachefiles kernel module directly reads and writes the files.

Correct.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
