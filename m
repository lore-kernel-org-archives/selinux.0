Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4F1fcjU028982
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 21:41:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40lKzj0K5Mz2NhLj
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 01:41:37 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40lKzg60Ktz2NhLY
 for <selinux@tycho.nsa.gov>; Tue, 15 May 2018 01:41:35 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id 16-v6so11261461lfs.13
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 18:41:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
References: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
 <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 21:39:33 -0400
Message-ID: <CAHC9VhQGmpjQxwmkY-3S7JtsGVQwmxQ7+hbGFEFEeGVFG4kaxA@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux <selinux@tycho.nsa.gov>,
 Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I run it several times a week on Rawhide, it's running fine for me.

FWIW, usually when people are having a problem running the
selinux-testsuite it is because they didn't follow the README very
closely.  I'm not saying that's the case here, but it couldn't hurt to
give it a second look ...

On Mon, May 14, 2018 at 7:48 PM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> It's been running fine for me. Maybe you just need to clean your tree and do
> a fresh make test.
>
> On Mon, May 14, 2018, 7:37 PM Casey Schaufler <casey@schaufler-ca.com>
> wrote:
>>
>> Has anyone had success with the SELinux test suite on Fedora 28?
>> I find the chcon and newrole are unhappy with the contexts used
>> in the suite.

-- 
paul moore
www.paul-moore.com
