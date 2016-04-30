Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7wahe016059
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:58:39 -0400
Received: by mail-pa0-f49.google.com with SMTP id bt5so54219168pac.3
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:58:38 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: genhomedircon userid patches v4
Date: Sat, 30 Apr 2016 15:58:05 +0800
Message-Id: <1462003092-4611-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey Stephen,

Here is a new version of the patch series for genhomedircon.

Changes from v3:
- Fixed Werror=sign-compare
- Rearranged the patches so each step builds and installs cleanly on my machine
3 became patch2.
2+4 became patch 3.

Changes from v2:
- Added extra char for NULL terminator for uid/gid.
- Check return code for snprintf

-- Jason
