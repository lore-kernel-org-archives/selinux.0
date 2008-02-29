Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T9oAIL030614
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 04:50:10 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T9o7uJ029955
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 09:50:08 GMT
Date: Fri, 29 Feb 2008 20:49:59 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
In-Reply-To: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0802292048010.27014@us.intercode.com.au>
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Feb 2008, Paul Moore wrote:

> While looking at the SELinux secid/secctx conversion functions I realized they
> could probably do with a little cleanup to reduce the amount of code and make
> better use of existing string processing functions in the kernel.  Making use
> of the kernel's existing string processing functions is a good idea as many
> architectures have specialized/optimized routines which should be an
> improvement over the generic code in the SELinux security server.

Please always include a signed-off-by line, in case the patch gets 
applied.

> -static int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
> +static int context_struct_to_string(struct context *context,
> +				    char **scontext, u32 *scontext_len)

I tend to not prefer the 80-column rule for function declarations, as it 
makes the code harder to grep (not a show-stopper, but generally, don't 
try and fix these).

- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
