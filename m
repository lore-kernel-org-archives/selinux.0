Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5Itjws025255
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 14:55:45 -0400
Received: by mail-wm0-f54.google.com with SMTP id f82so48238297wmf.1
 for <selinux@tycho.nsa.gov>; Sat, 05 Nov 2016 11:55:40 -0700 (PDT)
Received: from [192.168.0.25] ([151.58.14.242])
 by smtp.googlemail.com with ESMTPSA id 18sm3634875wmr.6.2016.11.05.11.55.38
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Nov 2016 11:55:38 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: mm <mm19827@gmail.com>
Subject: Security context of shared libraries
Message-ID: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
Date: Sat, 5 Nov 2016 19:55:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I have an executable started by /bin/foo which runs confined within the 
context foo_t.
The process loads (actually does LD_PRELOAD) bar.so which needs to 
access resources outside foo_t (actually unconfined_t).

I can allow access to such resources from foo_t, but I would like to 
allow such access only for code running within bar.so, instead of the 
whole process.

I have been looking in the docs, but I could not find if it is possible 
to specify a source context for shared libraries, instead of whole 
processes.
My idea would be to define a context bar_t for code running within 
bar.so, and allow the required access (to unconfined_t) from bar_t, 
without extending access for foo_t.

Makes sense? Is it possible?

Thanks in advance,
M. Manfredini
