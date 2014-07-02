Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s625A8CW017913
 for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2014 01:10:09 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so11824414pab.4
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 22:10:11 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.90.202])
 by mx.google.com with ESMTPSA id xk3sm35161286pbb.65.2014.07.01.22.10.09
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 01 Jul 2014 22:10:10 -0700 (PDT)
Message-ID: <53B39378.1090003@gmail.com>
Date: Wed, 02 Jul 2014 10:37:04 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Listing restrictions on roles.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There seem to exist additional non-transition restrictions on roles 
which define when will a process be able to execute as a certain role.

For e.g. a process which runs from a login shell cannot have system_r 
role. How do I list such rules?

Looking at role transition rules, a transition to system_r should be 
allowed --

sesearch --role_allow | grep system_r\;
...
allow unconfined_r system_r;
...

And the sudo process runs as unconfined_r --

ps auxZ | grep sudo
system_u:unconfined_r:unconfined_t:s0 root 669  0.0  0.4 206860 3356 
pts/1    S+   10:28   0:00 sudo -r unconfined_r nano

But sudo -r system_r nano fails.
