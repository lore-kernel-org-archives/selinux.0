Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5MINaU5031494
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 14:23:36 -0400
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
In-Reply-To: <20090622175003.GA2416@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com>
	 <1245682025.3033.178.camel@localhost.localdomain>
	 <20090622175003.GA2416@us.ibm.com>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 14:23:43 -0400
Message-Id: <1245695023.12493.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-06-22 at 12:50 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > Not sure you need to cache them in the cr layer (vs. just using the
> > mapping functions provided by the LSM hook interface, and letting the
> > security module handle caching internally).
> 
> Do I understand correctly that secids are supposed to be consistent
> across machines and reboots, but not across policy versions?

No, secids are temporal - they are dynamically allocated at runtime like
file descriptors.  You should only store security contexts in the
images.

> There are several ways we could handle this.  One is to have
> security_checkpoint_object() spit out an arbitrary void* which
> describes the *full* security context, with the checkpoint/restart
> layer completely unaware about the meaning of the contents.
> 
> Another is to have security_checkpoint_header() output the policy
> version, and for each checkpointed object just write out an array
> of secids.  If any file has a seqno which is not the same as the
> rest of the container's, then refuse the checkpoint?

No, I was referring to the seqno cached in the open file to determine
whether we need to revalidate on read/write.  I suppose resetting it to
zero on restore won't affect behavior, just performance.

> A third, which is what I was doing here, is to write out textual
> context representations, and expect the LSM on _restore() to
> know of a single meaningful interpretation for the context_str.

That's the right approach.

> Maybe adding a security_checkpoint_header() at the top of the
> checkpoint file would help with that (so that in the general case,
> if policy version at restart is different from the checkpointed one,
> we refuse restart, assuming that we can't meaningfully intepret
> even system_u:object_r:user_file_t).
> 
> > > At checkpoint, it takes a secid, stores the corresponding
> > > context string, and stores the objref for later use.
> > > At restart, read the context from checkpoint image,
> > > ask the security module for a secid, and store the secid
> > > on the objhash.
> > > 
> > > The per-object security c/r code will be responsible for
> > > getting secid from void*security at checkpoint time, and
> > > converting secid to void*security at restore time.
> > > 
> > > The code to c/r contexts for IPC objects is also in this
> > > patch.
> > > 
> > > For Smack, assign the label of the process doing sys_restart()
> > > if !capable(CAP_MAC_ADMIN), otherwise use the checkpointed
> > > label.
> > > 
> > > For SELinux, define a new 'restore' permission for ipc objects.
> > > (A corresponding trival policy patch adding 'restore' to the
> > > common flask permissions for refpolicy is also needed).  The
> > > caller of sys_restart() must have the class:restore permission
> > > to assign the checkpointed label, else restart will be refused.
> > > 
> > > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > 
> > > diff --git a/include/linux/checkpoint_hdr.h b/include/linux/checkpoint_hdr.h
> > > index e42e0db..e3fb9b3 100644
> > > --- a/include/linux/checkpoint_hdr.h
> > > +++ b/include/linux/checkpoint_hdr.h
> > > @@ -418,7 +426,7 @@ struct ckpt_hdr_ipc_perms {
> > >  	__u32 cuid;
> > >  	__u32 cgid;
> > >  	__u32 mode;
> > > -	__u32 _padding;
> > > +	__s32 secref;
> > 
> > Why s32 vs u32?  secids are u32 and 0 means they aren't supported by the
> > security module.
> 
> The secref is a reference to an object in the checkpoint/restart
> object hashtable, not a secid.  Those are signed, with <0 meaning
> error and 0 being a special case (in this case, 'not applicable')
> 
> If we write out the secids directly, which it sounds like you are
> advocating, and not the secid_to_secctx string, then we can store
> a u32 numsecs followed by __u32 secid[] which will have numsecs
> entries.

No, I just misunderstood what you meant by caching of the secids and by
the use of secref - never mind.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
