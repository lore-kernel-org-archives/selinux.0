Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t839xQO6032752
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 05:59:26 -0400
Received: by pav10 with SMTP id 10so1446516pav.1
 for <selinux@tycho.nsa.gov>; Thu, 03 Sep 2015 02:59:24 -0700 (PDT)
Received: from localhost ([59.189.205.185])
 by smtp.gmail.com with ESMTPSA id x6sm11541216pbt.3.2015.09.03.02.59.23
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2015 02:59:23 -0700 (PDT)
Date: Thu, 3 Sep 2015 17:59:20 +0800
From: Jason Zaman <jason@perfinion.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: bug: homedir fcontexts disappear when flipping a boolean
Message-ID: <20150903095920.GB15167@meriadoc.omgwtfbbq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

A user reported this bug and figured out how to reproduce it:
https://bugs.gentoo.org/558686

I am able to reproduce it on different systems also in permissive mode so it
can't be a policy issue. To reproduce, do the following:

To start off, everything is fine. all the other fcontext have no issues. and it
happens for all strict/mcs/mls.
# ls -al /etc/selinux/mls/contexts/files/file_contexts.homedirs*
-rw-r--r--. 1 root root  2981 Sep  3 09:47 /etc/selinux/mls/contexts/files/file_contexts.homedirs
-rw-r--r--. 1 root root 11493 Sep  3 09:47 /etc/selinux/mls/contexts/files/file_contexts.homedirs.bin

The boolean here is unimportant, so is on/off. I also tried using semanage
boolean -m and the effect is the same. The -P is important, without the -P
there is no problem.
# setsebool -P user_ping off

Note the file sizes after the boolean is set.
# ls -al /etc/selinux/mls/contexts/files/file_contexts.homedirs*
-rw-r--r--. 1 root root  0 Sep  3 09:48 /etc/selinux/mls/contexts/files/file_contexts.homedirs
-rw-r--r--. 1 root root 35 Sep  3 09:48 /etc/selinux/mls/contexts/files/file_contexts.homedirs.bin

The workaround is to just always rebuild the policy after booleans are set.
# semodule -B
# ls -al /etc/selinux/mls/contexts/files/file_contexts.homedirs*
-rw-r--r--. 1 root root  2981 Sep  3 09:49 /etc/selinux/mls/contexts/files/file_contexts.homedirs
-rw-r--r--. 1 root root 11493 Sep  3 09:49 /etc/selinux/mls/contexts/files/file_contexts.homedirs.bin

There is an strace excerpt in comment 8 in the gentoo bug. Does anyone have
the fix for this? I looked through the setsebool code and looks like it's a
problem in libsemanage but I did not look much further.

-- Jason
