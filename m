From: Paul Moore <paul.moore@hp.com>
To: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
Subject: Re: [PATCH] selinux: Unify for- and while-loop style
Date: Thu, 7 Aug 2008 08:15:24 -0400
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
References: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
In-Reply-To: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808070815.25086.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 06 August 2008 8:18:20 pm Vesa-Matti Kari wrote:
> Replace "thing != NULL" comparisons with just "thing" to make
> the code look more uniform (mixed styles were used even in the
> same source file).
>
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
> ---
>  security/selinux/ss/avtab.c       |    2 +-
>  security/selinux/ss/conditional.c |   16 ++++++++--------
>  security/selinux/ss/ebitmap.c     |    4 ++--
>  security/selinux/ss/hashtab.c     |    6 +++---
>  security/selinux/ss/services.c    |    8 ++++----
>  security/selinux/ss/sidtab.c      |   12 ++++++------

In my opinion this suffers from the same problems as the variable 
renaming patches.  I vote "no".

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
