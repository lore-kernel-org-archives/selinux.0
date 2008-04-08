From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] SELinux: Cleanup the secid/secctx conversion functions
Date: Tue, 8 Apr 2008 17:13:08 -0400
Cc: selinux@tycho.nsa.gov
References: <20080407230647.8052.79603.stgit@flek.lan> <20080407231101.8052.68591.stgit@flek.lan> <1207665824.21223.311.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207665824.21223.311.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804081713.08660.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 April 2008 10:43:44 am Stephen Smalley wrote:
> On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > @@ -709,73 +697,46 @@ static int security_context_to_sid_core(char
> > *scontext, u32 scontext_len, u32 *s null suffix to the copy to
> > avoid problems with the existing attr package, which doesn't view
> > the null terminator as part of the attribute value. */
> > -	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
> > -	if (!scontext2) {
> > -		rc = -ENOMEM;
> > -		goto out;
> > -	}
> > -	memcpy(scontext2, scontext, scontext_len);
> > -	scontext2[scontext_len] = 0;
> > +	scontext_dup = kmemdup(scontext, scontext_len + 1, GFP_KERNEL);
>
> Also, in addition to the gfp_flags change, I'm not clear that the
> above change is correct.  We are taking a byte array "scontext" of
> length "scontext_len" and copying it into a buffer of length
> "scontext_len+1" so that we can ensure that it is NUL terminated
> prior to parsing.  Won't kmemdup with scontext_len+1 ultimately run
> off the end of the original string?

Good point, I believe you're right.  I'll add this and the gfp stuff to 
the list of needed changes.

I think I may also suggest shelving this patch for 2.6.26 as a little 
birdie mentioned it would be a good idea to give this a through testing 
on non-MLS/MCS systems which I haven't yet done and don't expect to be 
able to do so before the merge window opens.

I haven't seen any objections to the other two patches, so I'll 
re-submit those for 2.6.27 and leave the secid/secctx cleanup for the 
next time around.

Thanks for the review.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
