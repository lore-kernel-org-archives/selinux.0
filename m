Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7TGE8cA024302
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 12:14:10 -0400
Received: from nm1.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p7TGE65G005101
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 16:14:07 GMT
Message-ID: <1314634446.62996.YahooMailClassic@web87002.mail.ird.yahoo.com>
Date: Mon, 29 Aug 2011 17:14:06 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: SELinux Common Intermediate Language Update
To: jwcart2@tycho.nsa.gov
Cc: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1314290814.11929.14.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does this mean that I need to declare the range components as nulls, for example:

(context context1 (unconfined_u  unconfined_r  unconfined_t (() ())))

or is CIL only for generating MCS/MLS policy.

What I've been trying to do is generate a simple policy based on 'mdp' in CIL and thought I would use secilc to generate the binary. However I found that secilc only supports generating MCS/MLS policy (although I hacked it enough to generate contexts as in the example above).

Richard

--- On Thu, 25/8/11, James Carter <jwcart2@tycho.nsa.gov> wrote:

> From: James Carter <jwcart2@tycho.nsa.gov>
> Subject: Re: SELinux Common Intermediate Language Update
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: "Steve Lawrence" <slawrence@tresys.com>, "SELinux" <selinux@tycho.nsa.gov>
> Date: Thursday, 25 August, 2011, 17:46
> On Thu, 2011-08-25 at 17:10 +0100,
> Richard Haines wrote:
> > I've been trying to generate a context for a non-mls
> policy but keep getting the following error:
> > 
> > Building Parse Tree...
> > Building AST from Parse Tree...
> > Invalid context (line: 12)
> > Failed to fill context, rc: -1
> > cil_gen_context failed, rc: -1
> > Failed to process node
> > cil_tree_walk failed, rc: -1
> > Failed to build ast, exiting
> > 
> > I've tried various formats of 'context' but all
> failed. One example:
> > ( context context1 ( unconfined_u unconfined_r
> unconfined_t ))
> > 
> > I see plenty of mls context examples in the test files
> but no non-mls.
> > Could you let me know the correct format please.
> > 
> 
> You always need to specify MLS current and clearance levels
> in CIL. The
> idea behind CIL is that we want a good foundation for
> building
> higher-level languages and tools, so we want minimize the
> special cases
> in the language syntax. Refpolicy already uses
> gen_context() for
> contexts, so just think of CIL as having gen_context()
> built in.
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
