Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: casey@schaufler-ca.com, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <9536.1187016680@redhat.com>
References: <353795.27307.qm@web36612.mail.mud.yahoo.com>
	 <9536.1187016680@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Aug 2007 10:57:32 -0400
Message-Id: <1187017052.26008.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-13 at 15:51 +0100, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > I haven't looked into the issues at all and I bet there are plenty,
> > maybe in audit and places outside of the security realm, but this
> > looks like a clean approach from the LSM interface standpoint. Do
> > you want the entire task or just task->security?
> 
> It would probably have to be the task struct, lest the security information
> (for which I've no refcount held) went away whilst I was trying to access it.
> 
> > I could see it either way, but I suspect the task is your best bet. If you
> > call security_act_as() twice, then security_act_as_self() do you pop a
> > stack, or return to the initial state?
> 
> Good point.  I've pondered that.  What I have at the moment partly acts like a
> stack in that I store some of the shifted-out context on the machine stack (in
> struct cachefiles_secctx).  The act-as context should probably be shifted too,
> in addition to the old file-creation SID and the fsuid/fsgid.
> 
> > How about security_act_as(NULL) returning you to the initial state, and
> > dropping security_act_as_self()?
> 
> That would be fine.
> 
> Actually, to address Stephen Smalley's requirements also, how about making
> things a bit more complex.  Have the following suite of functions:
> 
>  (1) int security_get_context(struct sec **_context);
> 
> 	This allocates and gives the caller a blob that describes the current
> 	context of all the LSM module states attached to the current task and
> 	stores a pointer to it in *_context.
> 
>  (2) int security_push(struct sec *context, struct sec **_old_context)
> 
> 	This causes all the LSM modules on the current task to switch to a new
> 	acting state, passing back the old state.  It does not change how
> 	other tasks do things to this one.
> 
>  (3) int security_pop(struct sec *context)
> 
> 	This causes all the LSM modules on the current task to switch to a new
> 	acting state, deleting the old state.  It does not change how
> 	other tasks do things to this one.
> 
>  (4) int security_delete_context(struct sec *context)
> 
> 	This deletes a context blob.
> 
> The context blob could then be structured very simply.  Give each loaded LSM
> module an integer index as it is registered.  Having a limit to the number of
> LSM modules would make things simpler.  The blob would then be an array of
> void pointers, one per LSM module, indexed by the integer index for each one.
> It you don't have a limit on the number of LSM modules, you'd also need a
> count of slots in the blob.
> 
> Any LSM module that wanted to implement the above three functions would fill
> in or otherwise use the slot that belongs to it.  Otherwise the slot would
> just be left NULL.
> 
> For example:
> 
> 	context --->+--------+                                    +---------+
> 	            | SLOT 0 |----------------------------------->| SELINUX |
> 	            +--------+                      +--------+    +---------+
> 	            | SLOT 1 |--------------------->| THINGY |
> 	            +--------+                      +--------+
> 	            | ...    |
> 	            +--------+         +-------+
> 	            | SLOT N |-------->| AUDIT |
> 	            +--------+         +-------+
> 
> For Stephen and NFS, he could then generate a context from NFS which nfsd
> could then put in place.  Perhaps any unfilled slot would be ignored by the
> LSM module to which it belonged.

Seems like over-design - we don't need to support LSM stacking, and we
don't need to support pushing/popping more than one level of context.

What was the objection again to the original interface, aside from
replacing "u32 secids" with "void* security blobs"?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
