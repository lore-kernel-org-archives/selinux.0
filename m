Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7DGKOM1002183
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 12:20:24 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7DGKNDa010169
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 16:20:23 GMT
Date: Mon, 13 Aug 2007 09:20:23 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com, torvalds@osdl.org,
        akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <10228.1187018526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <26859.95417.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Seems like over-design - we don't need to support LSM stacking, and we
> > don't need to support pushing/popping more than one level of context.
> 
> It will, at some point hopefully, be possible for someone to try, say, NFS
> exporting a cached ISO9660 mount (CDROM) - in which case, we'd should allow
> for two levels of stack.  If we can pass the displaced context to the caller
> to restore later then that allows for more or less unlimited depth.
> 
> It occurs to me that the following is almost good enough, but not quite:
> 
>   (1) int security_get_context(void **_context);
> 
> 	This allocates and gives the caller a blob that describes the current
> 	context of all the LSM module states attached to the current task and
> 	stores a pointer to it in *_context.

Is this intended to be anything more than a copy of current->security?

>   (2) int security_push(void *context, struct sec **_old_context)
> 
> 	This causes all the LSM modules on the current task to switch to a new
> 	acting state, passing back the old state.  It does not change how
> 	other tasks do things to this one.

I assume that you're talking about the LSM specific data changing,
not the LSM itself.

If you change the task->security information you are definitly going
to change what other tasks can do to the calling task. This is part of
the dark side of label swapping. This is what I was trying to suggest
when I said that if you're going to switch labels you switch to a
system-daemon label, do your work, then change the file label explicitly.
Stephen may have a trick up his sleeve for SELinux, but I don't
expect it to be pleasent.  

>   (3) int security_pop(void *context)
> 
> 	This causes all the LSM modules on the current task to switch to a new
> 	acting state, deleting the old state.  It does not change how
> 	other tasks do things to this one.

Same issues.

>   (4) int security_delete_context(void *context)
> 
> I still need a way to transform the cachefilesd context into the kernel's
> context.  See patch:
> 
>    Subject: [Linux-cachefs] [PATCH 12/16] CacheFiles: Get the SID under which
> 	the CacheFiles module should operate [try #3]
> 
> However, this seems to add a fairly generic tranformation, so that could be
> generalised:
> 
>   (5) int security_xfrm_to_kernel_context(void *from, void **_to);

Woof. What are you transforming from? 

> > What was the objection again to the original interface, aside from
> > replacing "u32 secids" with "void* security blobs"?
> 
> I got the impression that Casey thought much of this was tied to SELinux, but
> rereading his/her

"His" is preferred.

> emails, I'm not so certain.  Maybe that's sufficient. 
> Casey?

I did get the impression that your initial design was focused
on SELinux, and that the implications of alternative LSM modules
had not been very high on your priority list. It's clear from
your responses that you are taking the issue seriously. Thank you.

> However, I've realised a problem (as outlined above) with what I've got.
> Namely its stack isn't necessarily deep enough.  Alternatively, nfsd perhaps
> should suppress caching on what it reads.

That's the really nice thing about cans of worms.
They come in six-packs.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
