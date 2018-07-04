Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w64CaSxx003092
 for <selinux@tycho.nsa.gov>; Wed, 4 Jul 2018 08:36:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 41LL8B2J8Lz19Yj6
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 12:36:26 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 41LL894Q1bz19Yj1
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 12:36:25 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id u202-v6so4265023lff.9
 for <selinux@tycho.nsa.gov>; Wed, 04 Jul 2018 05:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <153055565291.30739.11949388336400371265.stgit@chester>
 <20180704.142853.1524154785411171806.davem@davemloft.net>
In-Reply-To: <20180704.142853.1524154785411171806.davem@davemloft.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Jul 2018 08:36:12 -0400
Message-ID: <CAHC9VhR4L5_zMyMsNqS2820rjGLOqEQR6mc2cHaR-Qmhbg-yQQ@mail.gmail.com>
To: davem@davemloft.net
Cc: Paul Moore <pmoore@redhat.com>, netdev@vger.kernel.org,
 viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC PATCH v2] ipv6: make ipv6_renew_options()
 interrupt/kernel safe
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 4, 2018 at 1:29 AM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Mon, 02 Jul 2018 14:20:52 -0400
>
> > -static int ipv6_renew_option(void *ohdr,
> > -                          struct ipv6_opt_hdr __user *newopt, int newoptlen,
> > -                          int inherit,
> > -                          struct ipv6_opt_hdr **hdr,
> > -                          char **p)
> > +static void ipv6_renew_option(int renewtype,
> > +                           struct ipv6_opt_hdr **dest,
> > +                           struct ipv6_opt_hdr *old,
> > +                           struct ipv6_opt_hdr *new,
> > +                           int newtype, char **p)
> >  {
>  ...
> > +     p += CMSG_ALIGN(ipv6_optlen(*dest));
>
> I don't think this actually advances the pointer in the caller,
> you need something like:
>
>         *p += CMSG_ALIGN(ipv6_optlen(*dest));

Yep, my mistake (typo); thanks for catching it.  Rebuilding a test
kernel now ...

-- 
paul moore
www.paul-moore.com
