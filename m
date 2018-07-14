Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6EGWAlr018326
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 12:32:10 -0400
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6EE50564713
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 18:31:59 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id r16-v6so67623170oie.3
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 09:31:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710085634.5671-1-vmojzis@redhat.com>
References: <CAJfZ7=nuYJ-=RHzCkiTkvt5-T+hG9GJgQtiz7X6AYHoorYwGsQ@mail.gmail.com>
 <20180710085634.5671-1-vmojzis@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 14 Jul 2018 18:31:57 +0200
Message-ID: <CAJfZ7=nEA3_V-KmWm-OWCLKRp1X1CxGfK-v5ZaTUzbj+yVBL6Q@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] python/semanage: Replace bare except with
 specific one
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 10, 2018 at 10:56 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
> The corresponding except clause should only be used for
> exceptions caused by audit module error or unavailability.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks. I applied your two patches.

Nicolas
