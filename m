Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5U9trEK018358
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 05:55:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 41Hpmk0sWXz2NhLh
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 09:55:50 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 41Hpmh6ftFz2NhLJ
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 09:55:48 +0000 (UTC)
Received: from mail-ot0-f180.google.com (mail-ot0-f180.google.com
 [74.125.82.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BB463564670
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 11:55:44 +0200 (CEST)
Received: by mail-ot0-f180.google.com with SMTP id c15-v6so12502570otl.3
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 02:55:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8230410.BG831gSa8N@localhost.localdomain>
References: <8230410.BG831gSa8N@localhost.localdomain>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 30 Jun 2018 11:55:42 +0200
Message-ID: <CAJfZ7=m6+TE-wKorvjxp6zUn3UQw_Ju2qrA5QqJRmgmPWJs+yg@mail.gmail.com>
To: Yuri Chornoivan <yurchor@ukr.net>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Fix minor typos
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jun 30, 2018 at 10:46 AM, Yuri Chornoivan <yurchor@ukr.net> wrote:
> Hi,
>
> Attached is a minor fix for the typos in selinux's git/master. Many thanks for
> fixing them.
>
> The patch is also available here:
>
> https://github.com/fedora-selinux/selinux/pull/52/commits/
> 7731e8fe46bce06a4915e5b772ce237b3021865b

Hello,
Your patch does not apply cleanly on
https://github.com/SELinuxProject/selinux master branch because the
typo in libselinux/man/man3/selinux_restorecon_xattr.3 has already
been fixed, with
https://github.com/SELinuxProject/selinux/commit/f42c3d4564322af9d6f573860a148f07abb36a6f
. Otherwise its content looks good to me. Thanks!

On the way you sent your patch, we prefer inline patches (sent with
"git send-email" for example) and we require a "Signed-off-by:" line
in the description. Could you please update the description, remove
the part which has already been fixed and send this patch again?

Thanks,
Nicolas
