Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8INUOCr005007
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 19:30:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 87C5B799CC
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 16:30:20 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id szZ4Vy5aAuvC for <selinux@tycho.nsa.gov>;
 Fri, 18 Sep 2015 16:30:20 -0700 (PDT)
Received: from [192.168.73.129] (wirelessgw.bbky.org [192.168.0.254])
 by mail.jlbond.com (Postfix) with ESMTP id 2FA2379768
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 16:30:20 -0700 (PDT)
Message-ID: <55FC9E8B.8000604@jlbond.com>
Date: Fri, 18 Sep 2015 16:30:19 -0700
From: Bond Masuda <bond.masuda@jlbond.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: how to run setsebool -P in chroot?
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
In-Reply-To: <20150911134151.GA6297@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I'm trying to run setsebool in a chroot environment like:

chroot /mnt/test /usr/sbin/setsebool -P antivirus_can_scan_system 1

But I get:

setsebool:  SELinux is disabled.

I'm guessing this is because the environment is not running. Is there a 
way around this? I need to be able to set some of the booleans this way.

Thanks
Bond
