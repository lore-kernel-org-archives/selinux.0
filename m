Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1TDcfmK027579
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 08:38:41 -0500
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1TDcYQO010081
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 13:38:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
Date: Fri, 29 Feb 2008 08:27:28 -0500
Cc: selinux@tycho.nsa.gov
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0802292048010.27014@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0802292048010.27014@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802290827.30364.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 February 2008 4:49:59 am James Morris wrote:
> On Thu, 28 Feb 2008, Paul Moore wrote:
> > While looking at the SELinux secid/secctx conversion functions I realized
> > they could probably do with a little cleanup to reduce the amount of code
> > and make better use of existing string processing functions in the
> > kernel.  Making use of the kernel's existing string processing functions
> > is a good idea as many architectures have specialized/optimized routines
> > which should be an improvement over the generic code in the SELinux
> > security server.
>
> Please always include a signed-off-by line, in case the patch gets
> applied.

Not including my sign-off is intentional as I've found it the only reliable to 
keep patches from being merged upstream before I'm happy with them.  In this 
particular case I've only booted the patch once or twice and was posting it 
to see if others felt it worthwhile before I spent any more time on it.

> > -static int context_struct_to_string(struct context *context, char
> > **scontext, u32 *scontext_len) +static int
> > context_struct_to_string(struct context *context,
> > +				    char **scontext, u32 *scontext_len)
>
> I tend to not prefer the 80-column rule for function declarations, as it
> makes the code harder to grep (not a show-stopper, but generally, don't
> try and fix these).

I find myself sticking pretty religiously to the 80-column rule, but you make 
a valid point that if I'm not changing the arguments I probably shouldn't 
mess with them.  I'll fix that up.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
