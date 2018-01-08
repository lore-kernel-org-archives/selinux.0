Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w08CIc5W027459
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 07:18:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08CDvPD026151
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 07:18:34 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fc8f689fg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 08 Jan 2018 07:18:33 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 12:18:31 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>
Date: Mon, 08 Jan 2018 07:18:25 -0500
In-Reply-To: <20180105211536.11611-2-mjg59@google.com>
References: <20180105211536.11611-1-mjg59@google.com>
 <20180105211536.11611-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515413905.3460.40.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-01-05 at 13:15 -0800, Matthew Garrett wrote:
> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is started.
> This will not change behaviour unless the system policy is extended to
> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> credentials that it did previously.

Refactoring IMA to pass the creds structure all the way down is a
generic solution, but if the CREDS_CHECK rule is only being called
from ima_bprm_check(), "container_of" the bprm->file returns a pointer
to the bprm structure.  Perhaps you could limit the amount of
refactoring needed based on the func.

I would prefer new arguments be added to process_measurement() only as
a last resort.

Could you include in the patch description a simple method for testing
this change?

thanks,

Mimi
