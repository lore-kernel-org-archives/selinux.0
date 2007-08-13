From: David Howells <dhowells@redhat.com>
In-Reply-To: <26859.95417.qm@web36612.mail.mud.yahoo.com>
References: <26859.95417.qm@web36612.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
Date: Mon, 13 Aug 2007 17:31:43 +0100
Message-ID: <13221.1187022703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >   (1) int security_get_context(void **_context);
> > 
> > 	This allocates and gives the caller a blob that describes the current
> > 	context of all the LSM module states attached to the current task and
> > 	stores a pointer to it in *_context.
> 
> Is this intended to be anything more than a copy of current->security?

It has to be sufficient to fully effect security_push().

> I assume that you're talking about the LSM specific data changing,
> not the LSM itself.

Yes.

> If you change the task->security information you are definitly going
> to change what other tasks can do to the calling task.

I dealt with that in my current act-as patch.  Under SELinux a task has two
primary labels.  One with which it is labelled and is used to govern effects
upon it, and one that is used to act upon things and follows changes to the
former.

> >   (5) int security_xfrm_to_kernel_context(void *from, void **_to);
> 
> Woof. What are you transforming from? 

In CacheFiles case, the cachefilesd daemon's security label into the label the
cache driver acts as on behalf of other processes.

> That's the really nice thing about cans of worms.
> They come in six-packs.

Yeah...

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
