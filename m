From: David Howells <dhowells@redhat.com>
In-Reply-To: <956034.72880.qm@web36610.mail.mud.yahoo.com>
References: <956034.72880.qm@web36610.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
Date: Thu, 20 Sep 2007 18:17:12 +0100
Message-ID: <14969.1190308632@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Could you use "object context" instead of "victimisation context"?
> It would be in better keeping with traditional security jargon.

If you wish.  Personally, I find it clearer than object or subject.

> > The separation is necessary for a few reasons:
> > 
> >  (1) The task victimisation context must *not* be changed by a temporary
> >      override of the action and creation contexts for purposes such as
> >      cachefiles.
> 
> That would be for the LSM to decide, not the file system.

Filesystem?  CacheFiles is acting on behalf of a filesystem and must override
the context that that filesystem was using, so that it can access a different
filesystem.

> While I concede that it is unlikely that you are going to want to use the
> same security attributes for your "object" and your "subject"

99.99% probable that I will want a different subjective context for talking to
the cache to the objective context of the task I'm doing work on behalf of.

> I also suggest that it is probable that the "object" attributes will want to
> change in the case of an filesystem daemon as well, 

What daemon are you referring to?

You've misunderstood, I think.  Consider readpages.  CacheFiles really wants to
run in the process context of whoever called readpages.  The main reason for
this is one of performance: readpages() is called an awful lot, and we don't
want to be changing process context at least twice per call if we can avoid it.

> and that the filesystem code by itself can't know what's correct.

Indeed.  I have mentioned that I intend to create a patch to provide an LSM
hook by which a kernel service can ask the LSM module for a new cred struct,
appropriate to that service.  That way, all details of SIDs, secids,
transformations, etc are hidden inside the LSM module.

> Assuming that the LSM goes along with the notion you could do that
> with a task struct, too.

Sigh.  Only by saving and restoring the complete credential context from/to the
task struct.

> So it sounds like what you'd be happiest with would be a separate task
> struct hand crafted to he the right "object" and "subject" attributes.

Exchanging task structs is highly impractical, I think.

> Couldn't you set up a task to do the overridden operations?

Performance.

> Yes, but the LSM writer now has to maintain two full security blobs
> even if the system doesn't want cachefs or nfs.

This is actually the simpler and cleaner solution.  It has been assumed,
generally, to this point that subjective context == objective context, but we
have two cases where we need to break that assumption.

> You could have done the same thing passing the task instead of a cred.

? I didn't mention passing a cred, did I?

> And I'm reluctantly withdrawing my objection to exporting secid's across the
> LSM interface

Actually, I think you were right.  I shouldn't be exposing secids like that.
There's no requirement for an LSM to have such a concept.

> I don't see any way to get around the LSM being involved, even with
> secid's.

Of course the LSM must be involved, but secids aren't needed.

> Only the LSM can decide what is appropriate for an override value. Maybe all
> you need is
> 
>     int security_task_godlikesecid(u32 *secid)

No, all I really need is something like:

	struct cred *security_get_kernel_service_cred(const char *name);

And maybe:

	int security_create_files_as(struct cred *, struct inode *);

So that I can say I want to be able to create files that look the same as that
inode there.  The LSM can then check that the subjective context in the cred
struct is allowed to do that.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
