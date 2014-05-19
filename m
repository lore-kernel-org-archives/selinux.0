Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4JGphDk024982
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 12:51:43 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so6003860pab.40
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 09:51:43 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.88.8])
 by mx.google.com with ESMTPSA id wn6sm13571525pab.18.2014.05.19.09.51.41
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 19 May 2014 09:51:42 -0700 (PDT)
Message-ID: <537A3600.7050006@gmail.com>
Date: Mon, 19 May 2014 22:19:04 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: system_u process does not have system_r
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've mapped user 'de' to system_u --

semanage login -l

Login Name           SELinux User         MLS/MCS Range Service

__default__          unconfined_u         s0-s0:c0.c1023       *
de                   system_u             s0-s0:c0.c1023       *
root                 unconfined_u         s0-s0:c0.c1023       *
system_u             system_u             s0-s0:c0.c1023       *

However the processes do not have system_r role, as a result the type 
value of many context fail to set cause unconfined_r is not allowed to 
have that type.

ps auxZ | grep nano
system_u:unconfined_r:unconfined_t:s0 de   544  0.0  0.3 115024 1568 
pts/1    S+   22:11   0:00 nano
system_u:unconfined_r:unconfined_t:s0 root 611  0.0  0.1 112632 888 
pts/0    S+   22:14   0:00 grep --color=auto nano

Actually unconfined_r role is not allowed for the user --

seinfo -uuser_u -x
    user_u
       default level: s0
       range: s0
       roles:
          object_r
          user_r
