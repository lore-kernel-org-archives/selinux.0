Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u21DVUdR007102
 for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2016 08:31:30 -0500
Received: by mail-qk0-f174.google.com with SMTP id s68so68780842qkh.3
 for <selinux@tycho.nsa.gov>; Tue, 01 Mar 2016 05:31:28 -0800 (PST)
Received: from [10.40.130.100] ([65.127.220.137])
 by smtp.googlemail.com with ESMTPSA id l20sm12869186qhc.24.2016.03.01.05.31.27
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 01 Mar 2016 05:31:27 -0800 (PST)
Reply-To: w.chimiak@ieee.org
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Bill <wch1m1@gmail.com>
Subject: Linux sandbox and the -i option
Message-ID: <56D599AE.3050009@gmail.com>
Date: Tue, 1 Mar 2016 08:31:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Is anyone else having issues with the
% sandbox -i [path]
not working?  What happens is the context is incorrectly done.

%ls -Zd /tmp/.sandbox_home_[whatever]
gives
unconfined_u:object_r:sandbox_file_t:s0:cxx,cyyy .
BUT
%ls -Z [path] is
gives
unconfined_u:object_r:mozilla_home_t:s0 [path]

This causes all sorts of read/write issues.

I guess I can write a script to do the
chcon, but that is a bit painful and you have to hunt
for the correct sandbox directory (not optimal at all).

Any suggestions?

-- 
William Chimiak
