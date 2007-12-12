From: David Howells <dhowells@redhat.com>
In-Reply-To: <830252.82380.qm@web36604.mail.mud.yahoo.com>
References: <830252.82380.qm@web36604.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 22:32:48 +0000
Message-ID: <612.1197498768@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > This fd selects the
> > particular cache context that a particular instance of a running daemon is
> > using.
> 
> Yes, but forgive me being slow, I don't see the problem.

I mean that it's not particularly sensible to have an auxiliary interface (say
a separate /sys/cachefiles file) for setting the cache context as there may be
several caches instantiated simply by opening /dev/cachefiles several times
and retaining all the file descriptors involved.

I meant this as information only.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
