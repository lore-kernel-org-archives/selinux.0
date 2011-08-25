Subject: Re: SELinux Common Intermediate Language Update
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Date: Thu, 25 Aug 2011 12:46:54 -0400
In-Reply-To: <1314288627.30252.YahooMailClassic@web87016.mail.ird.yahoo.com>
References: <1314288627.30252.YahooMailClassic@web87016.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314290814.11929.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-25 at 17:10 +0100, Richard Haines wrote:
> I've been trying to generate a context for a non-mls policy but keep getting the following error:
> 
> Building Parse Tree...
> Building AST from Parse Tree...
> Invalid context (line: 12)
> Failed to fill context, rc: -1
> cil_gen_context failed, rc: -1
> Failed to process node
> cil_tree_walk failed, rc: -1
> Failed to build ast, exiting
> 
> I've tried various formats of 'context' but all failed. One example:
> ( context context1 ( unconfined_u unconfined_r unconfined_t ))
> 
> I see plenty of mls context examples in the test files but no non-mls.
> Could you let me know the correct format please.
> 

You always need to specify MLS current and clearance levels in CIL. The
idea behind CIL is that we want a good foundation for building
higher-level languages and tools, so we want minimize the special cases
in the language syntax. Refpolicy already uses gen_context() for
contexts, so just think of CIL as having gen_context() built in.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
