Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UMcWM1026884
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 18:38:32 -0400
Received: by mail-oi0-f48.google.com with SMTP id p186so11854654oia.2
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 15:38:31 -0700 (PDT)
Received: from ian.penurio.us ([108.19.106.231])
 by smtp.gmail.com with ESMTPSA id h33sm17215365oth.33.2016.08.30.14.46.47
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Aug 2016 14:46:47 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Creating a new port type
Message-ID: <578825cb-5d96-1d51-c89e-40d7ee5cad03@gmail.com>
Date: Tue, 30 Aug 2016 16:46:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am attempting to write my first SELinux policy module (for the
Logitech Media Server/squeezeboxserver).  I would like to add a new
port type (slim_devices_port_t) for TCP and UDP 3483.

I haven't been able to find an example of how to do this, except for
stunnel.te, and the comments in that file don't lead me to believe that
it is the right way to do things.

Any pointers to examples or documentation would be appreciated.

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
