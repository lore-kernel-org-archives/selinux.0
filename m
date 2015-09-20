Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8KLDFWg014206
 for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2015 17:13:16 -0400
Received: by oiww128 with SMTP id w128so49590592oiw.2
 for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2015 14:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55FC9E8B.8000604@jlbond.com>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250> <55FC9E8B.8000604@jlbond.com>
Date: Sun, 20 Sep 2015 17:13:13 -0400
Message-ID: <CAHC9VhQHsb_F0KDatkqTaDxeJrVBU7xtsXg_aDWMnAJvAjQ66g@mail.gmail.com>
Subject: Re: how to run setsebool -P in chroot?
From: Paul Moore <paul@paul-moore.com>
To: Bond Masuda <bond.masuda@jlbond.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 18, 2015 at 7:30 PM, Bond Masuda <bond.masuda@jlbond.com> wrote:
> Hello,
>
> I'm trying to run setsebool in a chroot environment like:
>
> chroot /mnt/test /usr/sbin/setsebool -P antivirus_can_scan_system 1
>
> But I get:
>
> setsebool:  SELinux is disabled.
>
> I'm guessing this is because the environment is not running. Is there a way
> around this? I need to be able to set some of the booleans this way.

You are likely seeing the SELinux disabled message because you don't
have /sys/fs/selinux mounted in your chroot.

-- 
paul moore
www.paul-moore.com
