Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6S8XONS017792
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 04:33:24 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so3940449wib.10
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 01:33:25 -0700 (PDT)
Received: from [192.168.1.101] ([84.245.1.4])
 by mx.google.com with ESMTPSA id d4sm28840088wiy.13.2014.07.28.01.33.22
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Mon, 28 Jul 2014 01:33:23 -0700 (PDT)
Message-ID: <1406536400.32528.7.camel@x220.localdomain>
Subject: do user space object managers really provide mandatory access control
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Mon, 28 Jul 2014 10:33:20 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I admit that my knowledge of this leaves much to be desired but i will
ask anyway:

If one defines mandatory as "enforced by the kernel", then do user space
object managers provide mandatory access control?

from my understanding user space object managers enforce security
decisions made by the Linux security server.

So can a compromised user space object manager ignore these security
decisions made by the Linux security server?

In other words are user space object manager really a way to enforce MAC
or are they just another application layer access control when push
comes to shove.
