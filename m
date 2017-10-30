Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9UAsRA8008178
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 06:54:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3yQWZT3lr0z25sVD
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 10:54:25 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3yQWZT3C2Yz25sV9
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 10:54:25 +0000 (UTC)
Received: by mail-io0-f173.google.com with SMTP id m16so26142235iod.1
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 03:54:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 10:54:22 +0000
Message-ID: <CACdnJus0bb=LcbRjHVMMjHpi+NG3YV_DwF4UBT4uSoY=tHqyTQ@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 26, 2017 at 2:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/26/2017 1:40 AM, Matthew Garrett wrote:
>>  V3: Fix smack_cred_getsecid()
>
> Much better. Have you tried this with Smack?

I'm afraid not - I have zero expertise with Smack and no easy way to
set it up. I can do so later in the week if you like?
