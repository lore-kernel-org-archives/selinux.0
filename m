Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6KDL1bm007628
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 09:21:01 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6KDL0Q5014857
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 13:21:00 GMT
Received: by wa-out-1112.google.com with SMTP id k17so512962waf.0
        for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 06:21:00 -0700 (PDT)
Message-ID: <7e0fb38c0807200620m649d5cf8w8d57c9a3092450de@mail.gmail.com>
Date: Sun, 20 Jul 2008 09:20:59 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Vesa-Matti J Kari" <vmkari@cc.helsinki.fi>
Subject: Re: [patch]: ss/services.c null character style fix
Cc: selinux@tycho.nsa.gov, "Stephen Smalley" <sds@tycho.nsa.gov>,
        "James Morris" <jmorris@namei.org>
In-Reply-To: <Pine.LNX.4.64L.0807201434040.31208@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64L.0807201434040.31208@ruuvi.it.helsinki.fi>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch should be rebased against either the current Linus git tree
or James's SELinux tree.  This code has all been rewritten since
2.6.26 and as it stands this patch will not apply.  I prefer the '\0'
style so I'd be glad to see you rework the patch.  The other 4 patches
you sent are all obsolete and are no longer applicable so don't bother
with them.

Other things to know.

1) We prefer (as does most of the kernel) inline patches, but only if
you are sure your mailer isn't going to screw up the white space
rather than patches as attachments.
2) include a diffstat -p1 with the patch
3) All kernel patches require a 'Signed-off-by' line.
4) Your patch included DOS line endings (^M)  please run them through dos2unix
5) include the word SELinux in the subject as the subject usually
becomes the short changelog entry and not everyone would know that
this was in the SELinux subsystem.

Thanks for looking at these things!  (And I guess thanks to sds for
already dealing with a number of these, even if it was an accident)

-Eric


On Sun, Jul 20, 2008 at 7:43 AM, Vesa-Matti J Kari
<vmkari@cc.helsinki.fi> wrote:
>
> Hello,
>
> Patch against 2.6.26.
>
> ss/services.c null character style fix attached.
>
> In my opinion, it is better C-style to use the escaped version
> of null character when we deal with C-strings. So I always prefer:
>
>  c = '\0';
>
> to the
>
>  c = 0;
>
> although both are standards-compliant and correct.
>
> Best regards,
> vmk
> --
> ************************************************************************
>               Tietotekniikkaosasto / Helsingin yliopisto
>                 IT Department / University of Helsinki
> ************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
