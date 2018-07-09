Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w69KKoR2024933
 for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2018 16:20:52 -0400
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5255256122F
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 22:20:40 +0200 (CEST)
Received: by mail-oi0-f53.google.com with SMTP id k12-v6so38299485oiw.8
 for <selinux@tycho.nsa.gov>; Mon, 09 Jul 2018 13:20:40 -0700 (PDT)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 9 Jul 2018 22:20:38 +0200
Message-ID: <CAJfZ7=kyusEMDqACeTjJXaUWyZ0ATLi76hv2jYRHDV=SvUauUQ@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: libsemanage getpwent and nss-systemd incompability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While testing a systemd update on Arch Linux, I encountered the
following message (in a Vagrant virtual machine):

# semanage fcontext -m -s sysadm_u -t user_home_t '/vagrant(/.*)?'
libsemanage.get_home_dirs: Error while fetching users.  Returning list so far.

A quick debugging of get_home_dirs() in
libsemanage/src/genhomedircon.c shows that the loop "while ((pwbuf =
getpwent()) != NULL)" stops with pwbuf=NULL and errno=2 (ENOENT). My
/etc/nsswitch.conf contains:

passwd: files mymachines systemd

If I remove "systemd" from this line, the error disappears. Therefore
it seems that systemd's NSS module returns a ENOENT error when
getpwent() is called. I have not found any clue in systemd's code [1]
about such an error and I have not got much time to debug this issue.
Does this occurs for someone else (using Fedora for example)?

For information, this issue occurs with SELinux release 2.8 (and git
master branch), systemd 239.0 and glibc 2.27, on a system with SELinux
in permissive mode.

Best,
Nicolas

[1] https://github.com/systemd/systemd/blob/master/src/nss-systemd/nss-systemd.c
