Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBM0QvAa026643
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 19:26:57 -0500
Received: from e34.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBM0QtHk028527
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2010 00:26:55 GMT
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oBM0GI5t007821
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 17:16:18 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oBM0Qs1P162544
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 17:26:54 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oBM0Qsfk004538
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 17:26:54 -0700
Subject: Re: [PATCH] ima: fix add LSM rule bug
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        James
 Morris <jmorris@namei.org>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        David Safford <safford@watson.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
        Stable Kernel <stable@kernel.org>
In-Reply-To: <20101221143853.9cdd452b.akpm@linux-foundation.org>
References: <1292852223-10312-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <20101221143853.9cdd452b.akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Dec 2010 19:26:52 -0500
Message-ID: <1292977612.3888.64.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-12-21 at 14:38 -0800, Andrew Morton wrote:
> On Mon, 20 Dec 2010 08:37:03 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > If security_filter_rule_init() doesn't return a rule, then not everything
> > is as fine as the return code implies.
> > 
> > This bug only occurs when the LSM (eg. SELinux) is disabled at runtime.
> > 
> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > Cc: Stable Kernel <stable@kernel.org>
> > ---
> >  security/integrity/ima/ima_policy.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index aef8c0a..d661afb 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -253,6 +253,8 @@ static int ima_lsm_rule_init(struct ima_measure_rule_entry *entry,
> >  	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
> >  					   Audit_equal, args,
> >  					   &entry->lsm[lsm_rule].rule);
> > +	if (!entry->lsm[lsm_rule].rule)
> > +		return -EINVAL;
> >  	return result;
> >  }
> >  
> 
> You've cc'ed -stable but you didn't tell us what are the user-visible
> effects of this bug.  This makes it rather hard for others to
> understand why you believe the patch should be backported.

Adding an empty LSM rule causes ima_match_rules() to always succeed,
ignoring any remaining rules.  

 default IMA TCB policy:
  # PROC_SUPER_MAGIC
  dont_measure fsmagic=0x9fa0
  # SYSFS_MAGIC
  dont_measure fsmagic=0x62656572
  # DEBUGFS_MAGIC
  dont_measure fsmagic=0x64626720
  # TMPFS_MAGIC
  dont_measure fsmagic=0x01021994
  # SECURITYFS_MAGIC
  dont_measure fsmagic=0x73636673

  < LSM specific rule >
  dont_measure obj_type=var_log_t

  measure func=BPRM_CHECK
  measure func=FILE_MMAP mask=MAY_EXEC
  measure func=FILE_CHECK mask=MAY_READ uid=0

Thus without the patch, with the boot parameters 'tcb selinux=0', adding
the above 'dont_measure obj_type=var_log_t' rule to the default IMA TCB
measurement policy, would result in nothing being measuring. The patch
prevents the default TCB policy from being replaced.

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
