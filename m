Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85Jb9X1020959
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 15:37:11 -0400
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A3ED75647F4
 for <selinux@tycho.nsa.gov>; Wed,  5 Sep 2018 21:36:47 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id b15-v6so15875300oib.10
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 12:36:47 -0700 (PDT)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 5 Sep 2018 21:36:35 +0200
Message-ID: <CAJfZ7=niujB=XSC5D=y3fPrcL7rBBuLCsN_G=sy0N0bfDRYNJQ@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: "semanage user" and -s option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While reviewing the last patch sent by Vit Mojzis, I stumbled upon
something that does not feel right in "semanage user". Both "semanage
user --help" and "man 8 semanage-user" state:

usage: semanage user [-h] [-n] [-N] [-S STORE] [ --add ( -L LEVEL -R
ROLES -r RANGE -s SEUSER selinux_name) | ...

I am wondering what are the meaning of "-s SEUSER" and "selinux_name"
there. If I try to use "-s" option, semanage complains:

semanage: error: unrecognized arguments: -s

Therefore it seems that the usage would rather be "... --add ( -L
LEVEL -R ROLES -r RANGE SEUSER)". Looking at the code, it seems that
parser_add_seuser() is not used in setupUserParser() [1], and
everything works fine when using "semanage user" without -s option. Am
I missing something obvious, or should I write a patch which fixes the
documentation?

Cheers,
Nicolas

[1] https://github.com/SELinuxProject/selinux/blob/libsemanage-2.8/python/semanage/semanage#L403
