Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w04JMMcF001898
 for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2018 14:22:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3zCHk412KLz3GDP2
 for <selinux@tycho.nsa.gov>; Thu,  4 Jan 2018 19:22:20 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3zCHk36m9Qz3GDNw
 for <selinux@tycho.nsa.gov>; Thu,  4 Jan 2018 19:22:19 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id f190so3521519ita.5
 for <selinux@tycho.nsa.gov>; Thu, 04 Jan 2018 11:22:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bfb721eb-6066-4440-069f-d0089426b787@schaufler-ca.com>
References: <20180103012017.7022-1-mjg59@google.com>
 <20180103012017.7022-2-mjg59@google.com>
 <cd89f3cf-b620-b098-a3db-c53f05d330bf@schaufler-ca.com>
 <CACdnJuv7ADizvK8omRJA244N65ReYqWT2HSS_T=_uV66wMZ6Sg@mail.gmail.com>
 <a1054b8f-cebf-6c4b-be08-524d948b2449@schaufler-ca.com>
 <CACdnJus+EFtxrCH7RiKMtNqhm9CqWrvv9SviC7hncFB=8g4pew@mail.gmail.com>
 <bfb721eb-6066-4440-069f-d0089426b787@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 4 Jan 2018 11:17:14 -0800
Message-ID: <CACdnJutPiKUTUpS6d7G0zKjrCS8hR3xy1a+Xsi2Chyj7sAvayg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 LSM List <linux-security-module@vger.kernel.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V4 2/3] IMA: Use consistent creds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 3, 2018 at 12:08 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/3/2018 11:44 AM, Matthew Garrett wrote:
>> If we want to be able to do something conditional on the LSM context
>> that a process is going to be executed under, *before* commit_creds()
>> is called, is there an existing way to do so? I can rework this so we
>> use the task secid for all running processes and the cred secid for
>> the not-yet-running child process, but I don't know if that's
>> sufficient to avoid problems in future.
>
> It's possible that converting all the existing calls of
> security_task_getsecid() to security_cred_getsecid() is the
> safe approach. No one is using the task blob today, and this
> would disambiguate the situation.

Ok. Should we be looking at creds or real_creds?
