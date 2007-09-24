From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070924153541.GB26258@vino.hallyn.com>
References: <20070924153541.GB26258@vino.hallyn.com> <20070919161749.8334.26064.stgit@warthog.procyon.org.uk> <20070919161759.8334.11581.stgit@warthog.procyon.org.uk> <20070924140003.GA25689@vino.hallyn.com> <1190643719.487.41.camel@moss-spartans.epoch.ncsc.mil>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
Date: Mon, 24 Sep 2007 16:52:55 +0100
Message-ID: <11732.1190649175@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn <serge@hallyn.com> wrote:

> Ah, ok, so the daemon would use this to act under the user's
> credentials.  I was thinking the user would be using this to act
> under the daemon's or kernel's sid.

Think kernel service rather than daemon.  NFSd provides its own daemons to
override the security of, whereas cachefiles runs in the process context of
whoever called NFS.

> Between that and David's response, that this is only for the duration of
> one syscall (IIUC),

That's more or less correct.  You have to add the pagefault handler to that
list.

> My worry arose from the fact that I don't see
> security_cred_kernel_act_as() being called anywhere in this patchset...

Look in:

[PATCH 04/22] CRED: Request a credential record for a kernel service

Which was part of a patchset I sent on the 21st Sept.  get_kernel_cred() is in
turn used by:

[PATCH 13/22] CacheFiles: A cache that backs onto a mounted filesystem

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
