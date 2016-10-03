Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93GWG4g009796
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 12:32:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id s13so65439119pfd.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 09:32:13 -0700 (PDT)
Received: from localhost ([2404:e800:e600:540:f89b:d512:8a67:782a])
 by smtp.gmail.com with ESMTPSA id c4sm48637524pab.5.2016.10.03.09.32.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Oct 2016 09:32:10 -0700 (PDT)
Date: Tue, 4 Oct 2016 00:32:08 +0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: Received a base module, expected a non-base module.
Message-ID: <20161003163208.GA19093@meriadoc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey,

I cant load base.pp now on gentoo :(. this is with 2.6-rc1.

meriadoc mcs # semodule -vvv -b base.pp -i $(ls *.pp | grep -v base.pp)
The --base option is deprecated. Use --install instead.
Attempting to install module 'base.pp':
libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
semodule:  Failed on base.pp!
meriadoc mcs # semodule -vvv -b base.pp
The --base option is deprecated. Use --install instead.
Attempting to install module 'base.pp':
libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
semodule:  Failed on base.pp!
meriadoc mcs # semodule -vvv -i base.pp
Attempting to install module 'base.pp':
libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
semodule:  Failed on base.pp!

Anyone got any ideas?

-- Jason
