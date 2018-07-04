Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w64JPXuw012596
 for <selinux@tycho.nsa.gov>; Wed, 4 Jul 2018 15:25:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 41LWDC4mvzzJ33t
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 19:25:31 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 41LWDB4h0xzJ33s
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 19:25:30 +0000 (UTC)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0DBF6564843
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 21:25:24 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id k81-v6so12500086oib.4
 for <selinux@tycho.nsa.gov>; Wed, 04 Jul 2018 12:25:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4626168.H9xaOJR6cL@localhost.localdomain>
References: <8230410.BG831gSa8N@localhost.localdomain>
 <CAJfZ7=m6+TE-wKorvjxp6zUn3UQw_Ju2qrA5QqJRmgmPWJs+yg@mail.gmail.com>
 <4626168.H9xaOJR6cL@localhost.localdomain>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 4 Jul 2018 21:25:22 +0200
Message-ID: <CAJfZ7=kC5TAmv+aFfc72q0q43B+Y3GFMtBVYoegK4_r80Ygx7Q@mail.gmail.com>
To: Yuri Chornoivan <yurchor@ukr.net>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Fix minor typos
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jun 30, 2018 at 1:22 PM, Yuri Chornoivan <yurchor@ukr.net> wrote:
> субота, 30 червня 2018 р. 12:55:42 EEST ви написали:
>> On Sat, Jun 30, 2018 at 10:46 AM, Yuri Chornoivan <yurchor@ukr.net> wrote:
>> > Hi,
>> >
>> > Attached is a minor fix for the typos in selinux's git/master. Many thanks
>> > for fixing them.
>> >
>> > The patch is also available here:
>> >
>> > https://github.com/fedora-selinux/selinux/pull/52/commits/
>> > 7731e8fe46bce06a4915e5b772ce237b3021865b
>>
>> Hello,
>> Your patch does not apply cleanly on
>> https://github.com/SELinuxProject/selinux master branch because the
>> typo in libselinux/man/man3/selinux_restorecon_xattr.3 has already
>> been fixed, with
>> https://github.com/SELinuxProject/selinux/commit/f42c3d4564322af9d6f573860a1
>> 48f07abb36a6f . Otherwise its content looks good to me. Thanks!
>>
>> On the way you sent your patch, we prefer inline patches (sent with
>> "git send-email" for example) and we require a "Signed-off-by:" line
>> in the description. Could you please update the description, remove
>> the part which has already been fixed and send this patch again?
>>
>> Thanks,
>> Nicolas
>
> Many thanks for your review. The updated patch with a couple more fixes is
> attached.
>
> For some reason, 'git send-mail' does not work for my email provider ("Unable
> to initialize SMTP properly.", other clients like KMail and Trojita work
> fine). Sorry.

Thanks. I applied it.

Nicolas
