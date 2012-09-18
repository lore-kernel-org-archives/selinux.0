Message-ID: <5058C720.7000202@tresys.com>
Date: Tue, 18 Sep 2012 15:10:24 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        Joman Chu
	<jcchu@tycho.ncsc.mil>
Subject: Re: seandroid and policy version
References: <4FFCC3C7.8080602@tresys.com> <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil> <4FFDD7C7.4020703@tresys.com> <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil> <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil> <CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com> <CAFftDdpDkSWWzgKiCyTLuJpAZNRtihgmoRE0WhBcbGa2tdfwPA@mail.gmail.com> <1347992127.31966.93.camel@moss-pluto.epoch.ncsc.mil> <CAFftDdorhQYcJ4_76cFg-Nj49vLNJYkKHyM=Zz6RvZ+3jH31vw@mail.gmail.com> <1347994362.31966.109.camel@moss-pluto.epoch.ncsc.mil> <5058C5AA.4010809@tresys.com> <CAFftDdqWeUa1gTvrodNj3V7a7ggAwk1wNz1hOCTfLxdop8X=jQ@mail.gmail.com>
In-Reply-To: <CAFftDdqWeUa1gTvrodNj3V7a7ggAwk1wNz1hOCTfLxdop8X=jQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh right, the precedence in this build system gets me sometimes...

William Roberts wrote:
> Isn't that what ?= will let you do since it defers expansion? Again, I
> am no make guru...
>
> On Tue, Sep 18, 2012 at 12:04 PM, Joshua Brindle <jbrindle@tresys.com
> <mailto:jbrindle@tresys.com>> wrote:
>
>     Stephen Smalley wrote:
>
>         Attached are patches for libselinux and sepolicy to drop the policy
>         version suffix. We still force generation of a version 24 policy by
>         default, although this can be overridden via make command-line or
>         environment setting (e.g. export POLICYVERS=26). Does this seem
>         sane?
>         Note that seandroid-4.0.4 requires changes to system/core as
>         well, so
>         this only fixes it for master and 4.1.1.
>
>
>     Looks fine to me. Any chance that POLICYVERS could be set in a
>     device makefile? Since you'll know what kernel you are using to
>     build a particular device it would be nice to set it there and not
>     have to figure out/remember what version each device uses.
>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
