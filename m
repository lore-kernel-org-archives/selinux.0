Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBFMOeFL000471
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 17:24:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 3yz4jh26Lvz34qgT
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 22:24:40 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 3yz4jh1T3jz34qgN
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 22:24:40 +0000 (UTC)
Received: by mail-io0-f170.google.com with SMTP id u42so4169308ioi.9
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 14:24:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511908390.3473.30.camel@linux.vnet.ibm.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
 <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com>
 <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
 <1511908390.3473.30.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 15 Dec 2017 14:24:34 -0800
Message-ID: <CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hm, sorry, missed this mail.

On Tue, Nov 28, 2017 at 2:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
>> security_task_getsecid(current) will give the same results as
>> security_cred_getsecid(current_creds())
>
> Unwinding security_task_getsecid(current) looks like it is using
> real_cred, while current_cred() is using cred.

Good question, and there's a current_real_cred() macro, so I should
just use that instead.
