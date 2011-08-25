Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PGARFt017676
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 12:10:29 -0400
Received: from nm3-vm1.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p7PGASKm026777
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:10:28 GMT
Message-ID: <1314288627.30252.YahooMailClassic@web87016.mail.ird.yahoo.com>
Date: Thu, 25 Aug 2011 17:10:27 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: SELinux Common Intermediate Language Update
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4E552AC1.6030809@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been trying to generate a context for a non-mls policy but keep getting the following error:

Building Parse Tree...
Building AST from Parse Tree...
Invalid context (line: 12)
Failed to fill context, rc: -1
cil_gen_context failed, rc: -1
Failed to process node
cil_tree_walk failed, rc: -1
Failed to build ast, exiting

I've tried various formats of 'context' but all failed. One example:
( context context1 ( unconfined_u unconfined_r unconfined_t ))

I see plenty of mls context examples in the test files but no non-mls.
Could you let me know the correct format please.

Thanks
Richard


--- On Wed, 24/8/11, Steve Lawrence <slawrence@tresys.com> wrote:

> From: Steve Lawrence <slawrence@tresys.com>
> Subject: SELinux Common Intermediate Language Update
> To: "SELinux" <selinux@tycho.nsa.gov>
> Date: Wednesday, 24 August, 2011, 17:45
> As many of you know, we've been
> working on the SELinux Common
> Intermediate Language (CIL) compiler, called secilc, for
> many months now.
> 
> As a refresher, CIL is an intermediate language designed as
> a policy
> representation that sits between high level policy
> languages and the
> kernel policy representation. We're happy to answer any
> questions about
> the language, but for more information, please take a look
> at the CIL
> Design wiki at http://userspace.selinuxproject.org/trac/wiki/CilDesign
> 
> A few months ago, we released a version of secilc that
> could handle most
> of the features supported by reference policy and output a
> policy.conf
> file. We just recently reached a big milestone in that we
> can now
> generate binary policy files from only CIL source files.
> Because of
> this, we're dubbing this secilc v0.1.
> 
> Now that the compiler has reached this milestone, we would
> love for the
> community to play around with it a bit and give us any
> feedback as we
> continue on to integration with the existing SELinux tools
> and
> implementing more advanced features, such has inheritance
> and transforms.
> 
> The secilc v0.1 tarball can be downloaded here:
> 
> http://userspace.selinuxproject.org/cil/secilc-0.1.tar.gz
> 
> The secilc repository can be downloaded via git here:
> 
> $ git clone http://oss.tresys.com/git/cil.git
> 
> Thanks,
> Steve Lawrence
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
