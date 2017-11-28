Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vASLc28Z029329
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:38:02 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3ymcTc10BXzrKhS
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:37:56 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3ymcTc0MWNzrKhZ
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:37:56 +0000 (UTC)
Received: by mail-it0-f54.google.com with SMTP id u62so1567345ita.2
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 13:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511904917.3473.15.camel@linux.vnet.ibm.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
 <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 28 Nov 2017 13:37:52 -0800
Message-ID: <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
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

On Tue, Nov 28, 2017 at 1:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-11-28 at 13:22 -0800, Matthew Garrett wrote:
>> We need to check against the appropriate credentials structure, and
>> since we're doing this before commit_creds() has been called we can't
>> just do it against the one in the task structure.  For BPRM_CHECK
>> that'll be current_cred(), which means there's no change in
>> functionality, whereas for CREDS_CHECK it'll be the new credentials
>> structure.
>
> The existing code calls security_task_getsecid() with "current" not
> "current_cred".  Will replacing security_task_getsecid() with
> security_cred_getsecid() return the same info for the original
> BRPM_CHECK?

security_task_getsecid(current) will give the same results as
security_cred_getsecid(current_creds())
