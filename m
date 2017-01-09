Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v09Nnc4X001987
 for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2017 18:49:39 -0500
Received: by mail-ua0-f173.google.com with SMTP id i68so371254597uad.0
 for <selinux@tycho.nsa.gov>; Mon, 09 Jan 2017 15:49:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483987383.20858.84.camel@tycho.nsa.gov>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com> <58736B2E.90201@huawei.com>
 <20170109181225.GB8972@redhat.com> <20170109182915.GC8972@redhat.com>
 <1483987383.20858.84.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Jan 2017 18:49:36 -0500
Message-ID: <CAHC9VhT+sU5bEKiHFXuopDfo=w8gULrxnpJW1zzdD7_wX-tzDw@mail.gmail.com>
Subject: Re: SELinux lead to soft lockup when pid 1 proceess reap child
To: Stephen Smalley <sds@tycho.nsa.gov>, yangshukui <yangshukui@huawei.com>
Cc: Oleg Nesterov <oleg@redhat.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
 Qiang Huang <h.huangqiang@huawei.com>, Lizefan <lizefan@huawei.com>,
 "miaoxie (A)" <miaoxie@huawei.com>,
 Zhangdianfang <zhangdianfang@huawei.com>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, ebiederm@xmission.com,
 serge.hallyn@ubuntu.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 9, 2017 at 1:43 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2017-01-09 at 19:29 +0100, Oleg Nesterov wrote:
>> Seriously, could someone explain why do we need the
>> security_task_wait()
>> hook at all?
>
> I would be ok with killing it.
> IIRC, the original motivation was to block an unauthorized data flow
> from child to parent when the child context differs, but part of that
> original design was also to reparent the child automatically, and that
> was never implemented.  I don't think there is a real use case for it
> in practice and it just breaks things, so let's get rid of it unless
> someone objects.

Patches are always welcome, plenty of time to get things in for 4.11 :)

-- 
paul moore
www.paul-moore.com
