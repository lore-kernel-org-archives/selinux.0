Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w08Ju8VK023683
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 14:56:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zFmHC0DSBz3FjnC
 for <selinux@tycho.nsa.gov>; Mon,  8 Jan 2018 19:56:07 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zFmHB5lg7z3FjnB
 for <selinux@tycho.nsa.gov>; Mon,  8 Jan 2018 19:56:06 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08JsXuS121461
 for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2018 14:56:04 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fcf5hg5wn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 08 Jan 2018 14:56:03 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 19:56:00 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Mon, 08 Jan 2018 14:55:53 -0500
In-Reply-To: <CACdnJuvNz8Rjj2rBe=VTZKhOOnd+eXgp51sesEQF5_A+s2k3VQ@mail.gmail.com>
References: <20180105211536.11611-1-mjg59@google.com>
 <20180105211536.11611-2-mjg59@google.com>
 <1515413905.3460.40.camel@linux.vnet.ibm.com>
 <CACdnJuvNz8Rjj2rBe=VTZKhOOnd+eXgp51sesEQF5_A+s2k3VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515441353.3426.50.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2018-01-08 at 11:45 -0800, Matthew Garrett wrote:
> On Mon, Jan 8, 2018 at 4:18 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2018-01-05 at 13:15 -0800, Matthew Garrett wrote:
> >> The existing BPRM_CHECK functionality in IMA validates against the
> >> credentials of the existing process, not any new credentials that the
> >> child process may transition to. Add an additional CREDS_CHECK target
> >> and refactor IMA to pass the appropriate creds structure. In
> >> ima_bprm_check(), check with both the existing process credentials and
> >> the credentials that will be committed when the new process is started.
> >> This will not change behaviour unless the system policy is extended to
> >> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> >> credentials that it did previously.
> >
> > Refactoring IMA to pass the creds structure all the way down is a
> > generic solution, but if the CREDS_CHECK rule is only being called
> > from ima_bprm_check(), "container_of" the bprm->file returns a pointer
> > to the bprm structure.  Perhaps you could limit the amount of
> > refactoring needed based on the func.
> 
> Hm. This would avoid adding an argument to process_measurement(), but
> we'd still need to pass additional information down through
> ima_get_action() in order to get the creds and secid right. It feels a
> little ugly to have process_measurement() recreate information rather
> than having the caller pass it in, but I'm not going to object.

Agreed.  Initially, I was thinking that only ima_match_rules() would
use container_of, but the very first thing process_measurement() does
is get the inode from the file.  Everything afterwards passes the
inode.

> > Could you include in the patch description a simple method for testing
> > this change?
> 
> Certainly.

Thanks!

Mimi
