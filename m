Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44MRstT031544
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 18:27:56 -0400
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SE Linux <selinux@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Full SELinux labels on loopback for UDP
Message-ID: <ae25c71e-96a8-b83f-263c-feccc34bf02f@schaufler-ca.com>
Date: Thu, 4 May 2017 15:27:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Grubbing about in the SELinux netlabel code leads
me to ask how one would go about testing that the
local loopback (tag 6) CIPSO implementation works
for UDP. I can readily see how it all works for TCP.
Since I can't see how it works for UDP, I'd like to
have a test I can use to convince myself that it
does indeed work.
