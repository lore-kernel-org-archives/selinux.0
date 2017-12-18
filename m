Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBIFsjkJ008330
 for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2017 10:54:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFbvjt047203
 for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2017 10:39:31 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exewndb75-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2017 10:39:30 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:39:27 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Mon, 18 Dec 2017 10:39:21 -0500
In-Reply-To: <CACdnJuvwFOeOfVqYux+nw8n7qM=VLRFk6cK4HhQe13WCoHwvtA@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
 <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com>
 <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
 <1511908390.3473.30.camel@linux.vnet.ibm.com>
 <CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
 <CACdnJuvwFOeOfVqYux+nw8n7qM=VLRFk6cK4HhQe13WCoHwvtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513611561.5221.26.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-12-15 at 14:35 -0800, Matthew Garrett wrote:
> On Fri, Dec 15, 2017 at 2:24 PM, Matthew Garrett <mjg59@google.com> wrote:
> > Hm, sorry, missed this mail.

I was kind of wondering what happened...

> > On Tue, Nov 28, 2017 at 2:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
> >>> security_task_getsecid(current) will give the same results as
> >>> security_cred_getsecid(current_creds())
> >>
> >> Unwinding security_task_getsecid(current) looks like it is using
> >> real_cred, while current_cred() is using cred.
> >
> > Good question, and there's a current_real_cred() macro, so I should
> > just use that instead.
> 
> Hm. Actually, I'm not sure. For most checks we were using cred, and
> only using real_cred for the secid lookup. This feels somewhat
> inconsistent.

Even if it is a one line change, it shouldn't be hidden like this.
Please make it a separate patch, with the reason for the change.  We
need to make sure this change doesn't break existing systems.

thanks,

Mimi
