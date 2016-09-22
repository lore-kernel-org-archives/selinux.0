Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFIKYK015304
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:23 -0400
Received: by mail-pa0-f68.google.com with SMTP id oz2so3803054pac.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:17:52 -0700 (PDT)
Received: from localhost ([2404:e800:e600:57b:e014:183:951f:342c])
 by smtp.gmail.com with ESMTPSA id w9sm4971705pfg.34.2016.09.22.08.17.50
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Sep 2016 08:17:50 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: setools4 support
Date: Thu, 22 Sep 2016 23:17:26 +0800
Message-Id: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I finally got everything updated to use setools4. The most complicated parts
were sepolicy.search() and sepolicy.info() which were largely undocumented. I
dumped and diff'd the output from the old and new code so am fairly confident
that they are the same (barring some issues that setools3 appears to have with
cil). I also changed several places to just use setools directly, having the
indirection through search() mostly just complicates and slows things down.

The first patch is just cleanup. Next imports and initializes setools.
Patches 3-4 update a lot of the users of search() and info() to work with the next
changes.
Patches 5-6 update search() and info() themselves and the last drops the C
module completely

I dont know the status of setools4 on fedora (someone else will have to update
the README if needed) or others but I've added it masked in gentoo a fair while
ago. Once this patchset is merged we can finally get rid of setools3, its been
half-broken for a while now.

-- Jason
