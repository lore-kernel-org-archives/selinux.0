From: David Howells <dhowells@redhat.com>
In-Reply-To: <483979.69273.qm@web36605.mail.mud.yahoo.com>
References: <483979.69273.qm@web36605.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 22:29:55 +0000
Message-ID: <579.1197498595@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Yes, but we're talking about writing the configuration information
> to the kernel, not actually making any access checks with it. I
> think. What I think we're talking about (and please correct me David
> if I've stepped into the wrong theatre) is getting the magic
> secctx that cachefiles will use instead of the secctx that the task
> would have otherwise. I don't think we're talking about recomputing
> it on every access, I think David is looking for the blunderbuss
> secctx that he can use any time he needs one.

Indeed.

The way I do it is:

 (1) The daemon opens /dev/cachefiles to being an instance of a cache.

 (2) The daemon negotiates a security context for the module to use.

 (3) The security context is place in a task_security structure.

 (4) This task_security struct is attached temporarily to task->act_as each
     time any task attempts to access the cache through the module.

 (5) The task_security struct is discarded when the file descriptor that was
     created in (1) is closed and the cache is withdrawn at the same time.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
