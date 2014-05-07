Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s47FZ3Nn005544
 for <selinux@tycho.nsa.gov>; Wed, 7 May 2014 11:35:03 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1195014pde.1
 for <selinux@tycho.nsa.gov>; Wed, 07 May 2014 08:34:54 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.183.88])
 by mx.google.com with ESMTPSA id sm8sm3796739pbc.92.2014.05.07.08.34.51
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 07 May 2014 08:34:52 -0700 (PDT)
Message-ID: <536A51FE.1050506@gmail.com>
Date: Wed, 07 May 2014 21:02:14 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: sshd and default security context.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I was tying out default_contexts which has the following lines  --

cat default_contexts | grep sshd
system_r:sshd_t:s0              user_r:user_t:s0

And sshd does run with that type --

ps auxZ | grep sshd
system_u:system_r:sshd_t:s0-s0:c0.c1023 root 279 0.0  0.6 80636 3392 
?        Ss   09:20   0:00 /usr/sbin/sshd -D
system_u:system_r:sshd_t:s0-s0:c0.c1023 root 458 0.0  0.9 131280 4652 
?        Ss   09:22   0:00 sshd: de [priv]
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 468 0.0 0.4 
131280 2144 ? S 09:22   0:00 sshd: de@pts/0
system_u:system_r:sshd_t:s0-s0:c0.c1023 root 5115 1.1  0.9 131280 4624 
?       Ss   20:22   0:00 sshd: de [priv]
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5121 0.0 0.4 
131280 2124 ? S 20:22   0:00 sshd: de@notty

But the processes spawned by sshd do not have type user_t --

ps auxZ | grep user_t
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5183 0.0 0.1 
112632 884 pts/0 S+ 20:25   0:00 grep --color=auto user_t

I'm running the sleep command over SSH for e.g. but --

ps auxZ | grep sleep
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5126 0.0 0.1 
107888 504 ? Ss 20:22   0:00 sleep 10m

ps f -Ao args,label

COMMAND                     LABEL
/usr/sbin/sshd -D           system_u:system_r:sshd_t:s0-s0:c0.c1023
  \_ sshd: de [priv]         system_u:system_r:sshd_t:s0-s0:c0.c1023
  |   \_ sshd: de@pts/0 
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
  |       \_ -bash unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
  |           \_ ps f -Ao ar 
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
  \_ sshd: de [priv]         system_u:system_r:sshd_t:s0-s0:c0.c1023
      \_ sshd: de@notty 
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
          \_ sleep 10m unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

I'm aware of the possibility that ssh devs may have intended to use 
libselinux for a different purpose, but it's kind of pointless otherwise.

ldd $(which sshd) | grep selinux
         libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f4cf93f6000)
