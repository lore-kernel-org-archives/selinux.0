From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197557384.20226.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1197557384.20226.21.camel@moss-spartans.epoch.ncsc.mil> <1197488021.1125.138.camel@moss-spartans.epoch.ncsc.mil> <1197473127.1125.50.camel@moss-spartans.epoch.ncsc.mil> <81862.27432.qm@web36605.mail.mud.yahoo.com> <32168.1197484170@redhat.com> <668.1197499783@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Thu, 13 Dec 2007 15:36:59 +0000
Message-ID: <21666.1197560219@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> It is just a way of carving up the permission space, typically based on
> object type, but it can essentially be arbitrary.  The check in this
> case seems specific to cachefiles since it is controlling an operation
> on the /dev/cachefiles interface that only applies to cachefiles
> internal operations, so making a cachefiles class seems reasonable.

Can you specify what sort of permissions you're thinking of providing for
tasks to operate on this class?  Can an object of this class 'operate' on
other objects, or can only process-class objects do that?

How does an object of this class acquire a label?  What is an object of this
class?  Is it a "cache"?  Or were you thinking of a "module"?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
