From: David Howells <dhowells@redhat.com>
In-Reply-To: <336290.70309.qm@web36603.mail.mud.yahoo.com>
References: <336290.70309.qm@web36603.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 18:34:26 +0000
Message-ID: <32187.1197484466@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> What sort of authorization are you thinking of? I would expect
> that to have been done by cachefileselinuxcontext (or
> cachefilesspiffylsmcontext) up in userspace. If you're going to
> rely on userspace applications for policy enforcement they need
> to be good enough to count on after all.

It can't be done in userspace, otherwise someone using the cachefilesd
interface can pass an arbitrary context up.  The security context has to be
passed across the file descriptor attached to /dev/cachefiles along with the
other configuration parameters as a text string.  This fd selects the
particular cache context that a particular instance of a running daemon is
using.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
