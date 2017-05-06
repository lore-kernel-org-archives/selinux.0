Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46Njwq8010950
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 19:45:58 -0400
Received: by mail-oi0-f51.google.com with SMTP id l18so19822167oig.2
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 16:45:51 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-136-2.tx.res.rr.com. [70.119.136.2])
 by smtp.gmail.com with ESMTPSA id
 r203sm4657505oif.15.2017.05.06.16.45.49 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 06 May 2017 16:45:50 -0700 (PDT)
To: selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Does recvfrom(2) imply { getattr }?
Message-ID: <f08e1e6f-81be-1255-ca80-2ee9594b5739@gmail.com>
Date: Sat, 6 May 2017 18:45:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm getting a non-fatal { getattr } denial on a UDP socket (talking to a
DNS server).  strace doesn't show any fstat calls on the socket, but it
does show that recvfrom is being called.

Does recvfrom want getattr permission in order to retrieve the message
source?  (The other potential system calls are poll and
ioctl(FIONREAD).)

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
