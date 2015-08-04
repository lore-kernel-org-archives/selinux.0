Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t74MXQNh005519
 for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2015 18:33:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 57C0079BEA
 for <selinux@tycho.nsa.gov>; Tue,  4 Aug 2015 15:33:06 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id TAjRHuGwBP2C for <selinux@tycho.nsa.gov>;
 Tue,  4 Aug 2015 15:33:06 -0700 (PDT)
Received: from taipei.bbky.org (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 1387278914
 for <selinux@tycho.nsa.gov>; Tue,  4 Aug 2015 15:33:06 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Bond Masuda <bond.masuda@jlbond.com>
Subject: How do you relabel all SELinux file contexts of an offline system's
 file system?
Message-ID: <55C13DA1.2070601@jlbond.com>
Date: Tue, 4 Aug 2015 15:33:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Normally, if I need to ensure that all the SELinux file contexts are
correct, I run:

restorecon -R -v /

However, in the current situation, I need to do that on a system that is
offline, where I have it's root and entire file system mounted under
/mnt. I tried:

chroot /mnt /usr/sbin/restorecon -R -v /mnt

hoping it would have the same effect, but it does not appear to. When I
boot the offline system, it shows a lot of SELinux mislabelings.

Is there a way to fix SELinux file contexts of another system while it
is offline?

Thanks for any help...
-Bond
