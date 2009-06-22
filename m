Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5MEl1xn025444
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 10:47:01 -0400
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
In-Reply-To: <20090620013216.GA4435@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 10:47:05 -0400
Message-Id: <1245682025.3033.178.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-06-19 at 20:32 -0500, Serge E. Hallyn wrote:
> Here is the next version of the patch implementing checkpoint
> and restore of LSM contexts.  This is just handling IPC objects
> as a proof of concept.  But actually, looking ahead and both
> files and tasks, I see that selinux stores several sids in the
> security structs.  For instance, for tasks there is the current
> sid, exec sid, create sid, keycreate_sid, and sockcreate_sid.
> So I guess I'll have to ask the LSM for how many secids it wants
> to checkpoint, then checkpoint an array of contexts?

You will need to support checkpointing multiple secids/contexts per
object, but what about other state that might live in the security
structs, e.g. flags fields, policy seqno, etc.

> >From 19669b07cdfef4d377f3f188e2421c4124e38708 Mon Sep 17 00:00:00 2001
> From: Serge E. Hallyn <serue@us.ibm.com>
> Date: Wed, 17 Jun 2009 12:00:21 -0400
> Subject: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
> 
> Introduce a cache of secids for checkpoint and restart.

Not sure you need to cache them in the cr layer (vs. just using the
mapping functions provided by the LSM hook interface, and letting the
security module handle caching internally).

> At checkpoint, it takes a secid, stores the corresponding
> context string, and stores the objref for later use.
> At restart, read the context from checkpoint image,
> ask the security module for a secid, and store the secid
> on the objhash.
> 
> The per-object security c/r code will be responsible for
> getting secid from void*security at checkpoint time, and
> converting secid to void*security at restore time.
> 
> The code to c/r contexts for IPC objects is also in this
> patch.
> 
> For Smack, assign the label of the process doing sys_restart()
> if !capable(CAP_MAC_ADMIN), otherwise use the checkpointed
> label.
> 
> For SELinux, define a new 'restore' permission for ipc objects.
> (A corresponding trival policy patch adding 'restore' to the
> common flask permissions for refpolicy is also needed).  The
> caller of sys_restart() must have the class:restore permission
> to assign the checkpointed label, else restart will be refused.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

> diff --git a/include/linux/checkpoint_hdr.h b/include/linux/checkpoint_hdr.h
> index e42e0db..e3fb9b3 100644
> --- a/include/linux/checkpoint_hdr.h
> +++ b/include/linux/checkpoint_hdr.h
> @@ -418,7 +426,7 @@ struct ckpt_hdr_ipc_perms {
>  	__u32 cuid;
>  	__u32 cgid;
>  	__u32 mode;
> -	__u32 _padding;
> +	__s32 secref;

Why s32 vs u32?  secids are u32 and 0 means they aren't supported by the
security module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
