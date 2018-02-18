Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1II9hJS014958
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 13:09:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3zkvzT3c33z3GDS1
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 18:09:41 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3zkvzT2yLDz3GD9h
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 18:09:41 +0000 (UTC)
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1AF4D56007D
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 19:09:36 +0100 (CET)
Received: by mail-lf0-f53.google.com with SMTP id h78so10211270lfg.6
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 10:09:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214095337.1945-1-plautrba@redhat.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 18 Feb 2018 19:09:35 +0100
Message-ID: <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Update selinux-sepolgengui to be compatible with Gtk3, Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 14, 2018 at 10:53 AM, Petr Lautrbach <plautrba@redhat.com> wrote:
> Hi,
>
> The following set of patches update polgengui.py, rename polgen.glade to
> polgen.ui, convert it to new format, and fix some other sepolicy Python 3
> related issues.

Hi,
I have read and tested these patches and they look good to me.
