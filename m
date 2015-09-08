Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t88BF5TO026523
 for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2015 07:15:05 -0400
Received: by obqa2 with SMTP id a2so80112493obq.3
 for <selinux@tycho.nsa.gov>; Tue, 08 Sep 2015 04:15:03 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <CA+=dQ--oYEnzndkEFRWWxuX4t3n3sardYeLL5TWVJbzm=eLZPA@mail.gmail.com>
References: <CA+=dQ--oYEnzndkEFRWWxuX4t3n3sardYeLL5TWVJbzm=eLZPA@mail.gmail.com>
Date: Tue, 8 Sep 2015 13:15:03 +0200
Message-ID: <CAPzO=Ny-Z42GZZBGuju8LWwGeNTWaGhs1hY8Xi1WihuLNqq6kg@mail.gmail.com>
Subject: Re: Not able to enter root after enabling selinux
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 8, 2015 at 12:16 PM, Divya Vyas <dvyas@mvista.com> wrote:
> After I enabled selinux with default policy , I am not able to enter root
> neither ssh it.
>
> semanage login -l
>
> Login Name                SELinux User
>
> __default__               user_u
> root                      root
> system_u                  system_u
>
> Which user I should login?
>
> conifg file is :
>
> SELINUX=enforcing
> # SELINUXTYPE= can take one of these two values:
> #     standard - Standard Security protection.
> #     mls - Multi Level Security protection.
> SELINUXTYPE=mls

Without error message and log events, it's difficult to help you out with this.

That being said, I notice you are going to use an MLS policy store.
MLS is not a security model that is often used. Most distributions
don't even support it properly (for instance, with Gentoo, we offer
MLS but can't really support it) because there are more complexities
to consider than with MCS or strict/targeted policies. Do you have a
particular reason to use MLS? Did you try first with a different
policy store/security model?

Wkr,
  Sven Vermeulen
