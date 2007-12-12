From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197473127.1125.50.camel@moss-spartans.epoch.ncsc.mil>
References: <1197473127.1125.50.camel@moss-spartans.epoch.ncsc.mil> <81862.27432.qm@web36605.mail.mud.yahoo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 18:29:30 +0000
Message-ID: <32168.1197484170@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> That sounds workable, although I think he will want a more specific hook
> than security_secctx_to_secid(), or possibly a second hook call, that
> would not only validate the context but authorize the use of it by the
> cachefilesd process.  And then the security_task_kernel_act_as() hook
> just takes the secid as input rather than the task struct of the daemon,
> and applies it.  At that point, nfsd can use the same mechanism for
> setting the acting SID based on the client process after doing its own
> authorization.

I thought using secids was verboten as it made things too specific.

Have you example code for the security hook you mention?  I'm not sure I
understand why security_secctx_to_secid() is not sufficient.

Or is it that I need something that takes a secctx, converts it to a secid and
authorises its use all in one go?  If it's this, why can't that be rolles into
security_task_kernel_act_as()?  That sets up a task_security struct which is
then switched in and out without consultation of the LSM.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
