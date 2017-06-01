Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v519UHNV022027
 for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2017 05:30:17 -0400
Cc: 863854-forwarded@bugs.debian.org
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: selabel_lookup_raw() doesn't find correct context for path with
 double slashes
Message-ID: <070cda6f-fcdf-1cd0-9989-9cc97eaaf49d@debian.org>
Date: Thu, 1 Jun 2017 11:29:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While investigating a bug about systemd/udev not setting the proper 
context on the hwdb.bin file, Michael Biebl discovered that apparently 
the selabel_lookup_raw() function is not coping properly with paths with 
double slashes (like "//lib/udev/hwdb.bin")

Shouldn't the selabel_lookup*() functions be more resilient to this 
case? Or should application canonicalize (with realpath()?) the path 
before calling these functions?

Regards,

Laurent Bigonville

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863854
