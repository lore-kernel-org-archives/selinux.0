Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77H7njE027938
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 13:07:49 -0400
Received: by vcbfl17 with SMTP id fl17so4684599vcb.12
        for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2012 10:07:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120807130244.GE2085@telvanni>
References: <20120807130244.GE2085@telvanni>
Date: Tue, 7 Aug 2012 10:07:47 -0700
Message-ID: <CAFftDdq9JhRXMTDP4ZSsDOhpUAb5vDAAKPmNJ3Zf_KaeBRzxYw@mail.gmail.com>
Subject: Re: SELinux performance depending on type count
From: William Roberts <bill.c.roberts@gmail.com>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well as far as caching goes, their are cache misses, so as the amount
of data increase and your cache size stays fixed, they may be an
issue...

On Tue, Aug 7, 2012 at 6:02 AM, Ole Kliemann <ole@plastictree.net> wrote:
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



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
