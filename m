From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197566877.20226.130.camel@moss-spartans.epoch.ncsc.mil>
References: <1197566877.20226.130.camel@moss-spartans.epoch.ncsc.mil> <1197563033.20226.110.camel@moss-spartans.epoch.ncsc.mil> <1197557384.20226.21.camel@moss-spartans.epoch.ncsc.mil> <1197488021.1125.138.camel@moss-spartans.epoch.ncsc.mil> <1197473127.1125.50.camel@moss-spartans.epoch.ncsc.mil> <81862.27432.qm@web36605.mail.mud.yahoo.com> <32168.1197484170@redhat.com> <668.1197499783@redhat.com> <21666.1197560219@redhat.com> <22549.1197565271@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Thu, 13 Dec 2007 18:04:04 +0000
Message-ID: <23942.1197569044@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Do any of the interfaces allow a task to act on a cache other than one
> it has created?

No.

> How does the task identify the desired cache?

Each file descriptor opened creates one separate cache instance.  Any commands
sent over that filedescriptor affect only the cache instance it is attached
to; similarly, any status data you read only refers to that one cache
instance.

Closing the file descriptor makes the cache go away as far as the kernel is
concerned.  The cachefiles daemon retains its cache dev file descriptor for
the lifetime of the daemon.

> What if there is a conflict between multiple tasks asking for the same
> cache?

As far as the cache daemon is concerned, the file descriptor is its handle to
the cache so the conflict does not arise.

> secid is being applied as the acting context for the cachefiles kernel
> module, so the above makes sense, even though there isn't really any
> "object" in view here.  Abstractly, the question we are asking above is:
>
> Can this task set the context of the cachefiles kernel module to this
> value?

So the following (taken from cachefilesd.te):

	allow cachefilesd_t cachefiles_var_t : file { getattr rename unlink };

says, for example, allow:

	avc_has_perm("cachefilesd_t",
		     "cachefiles_var_t",
		     SECCLASS_FILE,
		     FILE__RENAME,
		     ...);

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
