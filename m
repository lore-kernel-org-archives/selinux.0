Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77EC6Lc017255
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 10:12:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 07 Aug 2012 10:12:07 -0400
From: David Quigley <selinux@davequigley.com>
To: Ole Kliemann <ole@plastictree.net>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux performance depending on type count
In-Reply-To: <20120807130244.GE2085@telvanni>
References: <20120807130244.GE2085@telvanni>
Message-ID: <b8279b8f0156d2c636458353c1646c9c@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/07/2012 09:02, Ole Kliemann wrote:
> I read on some locations (Fedora FAQ...) that there is an overall
> performance impact of about 7% when running with SELinux.
>
> Does anyone know if this impact is dependent upon the number of
> types the policy has? I would assume no: A lot of types only take
> up memory and caching should prevent any impact on the runtime
> performance.
>
> But if there was a performance problem with a lot of types, at
> what number n would it start to hit hard? And how does it
> increase (linear, quadratic...)?
>
> And would it be better performance-wise to run a MCS-policy with
> say categories c0.cn than to have types c0_t, ... cn_t?
>
> Ole

I don't believe anyone has done recent benchmarks on SELinux overhead. 
However in that study the overhead mostly comes from the permission 
checks in the various layers of the Linux kernel. There were some issues 
associated with access vector cache overhead but those were fixed I 
believe by some contributors from Japan. The largest offender was the 
checks on read/write since we checked on every single call to read/write 
before. That was fixed so we don't do the full computation every time. 
We only do it on the first read/write and only recheck on policy change 
or label change since it invalidates our earlier check. It would be nice 
to see a more recent study on SELinux overhead.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
