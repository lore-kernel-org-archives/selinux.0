Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9UAvEF7009695
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 06:57:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3yQWdm0lqwz25sVB
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 10:57:16 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3yQWdm06WBz25sV4
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 10:57:16 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id b186so26159337iof.8
 for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2017 03:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509027658.25604.4.camel@tycho.nsa.gov>
References: <20171026084055.25482-1-mjg59@google.com>
 <1509027658.25604.4.camel@tycho.nsa.gov>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 10:57:11 +0000
Message-ID: <CACdnJuu8fvVoD+G50dWtauUUa3H1tUAbBgzusc_CKNBugrVmwQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 26, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett via Selinux wrote:
>> +static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
>> +{
>> +     rcu_read_lock();
>> +     *secid = cred_sid(c);
>> +     rcu_read_unlock();
>
> Is rcu_read_lock() necessary here? Seems like we use cred_sid() in many
> places without it.

Ah, I thought it was based on task_sid(), but I guess that's actually
protecting the __task_cred()?
