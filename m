Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3PJL54e012209
 for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2014 15:21:09 -0400
Message-ID: <535AB58A.1050500@tresys.com>
Date: Fri, 25 Apr 2014 15:20:42 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, <selinux@tycho.nsa.gov>,
 <setools-bugs@tresys.com>, <brindle@quarksecurity.com>
Subject: Re: [PATCH] setools: Update to load v29 policy source files.
References: <1397573043-21748-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1397573043-21748-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2014 10:44 AM, Richard Haines wrote:
> This uses the policy build files from checkpolicy-2.1.12-5.fc20 that
> are then modified to be used in setools for source policy expansion.
> The files have comments /* Required for SETools libqpol */ added to
> allow for easier patching next time.
> 
> This patch should now enable all policy features up to policy version 29.
> 
> There are #defines in policy.c infer_policy_version() to determine the
> max version the policy should support when being built, however they
> have not been fully tested.
> 
> The source policy expansion has been tested using apol on Fedora 20.
> 
> There is one bug where filename type_transition rules are added twice.
> This is a problem in libsepol (expand.c copy_and_expand_avrule_block())
> that adds these rules again - have a fix for this - probably.
> 
> There are two bug fixes:
> 1) Add range field to default_range.
> 2) Toggle apol "Policy Source" tab correctly.
> 
> This patch MUST be applied on top of the four patches available from:
> http://marc.info/?l=selinux&m=139696911602613&w=2
> 
> or (the preferred approach), a fully patched version of setools is
> available from: https://github.com/QuarkSecurity/setools
> 
> With RPMs at: https://quarksecurity.com/files/RPMS/
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Applied.

Thanks!
- Steve
