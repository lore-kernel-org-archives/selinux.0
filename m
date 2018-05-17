Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5BYQ1005734
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:11:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40mfXy1CZ4zrKYY
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:11:30 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40mfXx1KcZzrKYC
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:11:29 +0000 (UTC)
Received: by mail-pl0-f65.google.com with SMTP id e6-v6so1763677plt.11
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:11:27 -0700 (PDT)
Received: from localhost ([2404:e800:e600:402:a043:dee9:8fe1:5766])
 by smtp.gmail.com with ESMTPSA id v186-v6sm6382210pfb.45.2018.05.16.22.11.24
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 May 2018 22:11:25 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:12 +0800
Message-Id: <20180517051117.48454-1-jason@perfinion.com>
Subject: SELinux musl support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This series fixes compiling and running on musl libc.

patches 1-2 are fairly trivial.

patches 3-4 are a feature change on that platform since it does not
support GLOB_TILDE and GLOB_BRACE. tilde is coming in musl 1.1.21
according to [1]. brace support is not documented anywhere or in the
example configs so that is probably not a big problem.

patch 5 fixes a bug and it just happens that glibc returns a value for
sysconf and the error handling was wrong but never noticed.

[1]: https://wiki.musl-libc.org/roadmap.html

[PATCH 1/5] sestatus: include limits.h for PATH_MAX
[PATCH 2/5] libselinux: enable linking to musl-fts
[PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and
[PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE and
[PATCH 5/5] genhomedircon: sysconf can return -1 without failure
