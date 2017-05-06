Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v464sObL018606
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 00:54:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id m17so1200363oik.2
 for <selinux@tycho.nsa.gov>; Fri, 05 May 2017 21:54:23 -0700 (PDT)
To: python-list@python.org
Cc: selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Why does Python want to read /proc/meminfo
Message-ID: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
Date: Fri, 5 May 2017 23:54:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am trying to write an SELinux policy to confine a simple service that
I have written in Python, and I'm trying to decide whether to allow or
dontaudit various denials.

To start, I've reduced my service to the simplest case:

   #!/usr/bin/python

   import sys

   sys.exit()

Running this program in a confined domain generated the following
denial:

avc:  denied  { read } for  pid=2024 comm="denatc" name="meminfo" 
dev="proc" ino=4026532028 scontext=system_u:system_r:denatc_t:s0 
tcontext=system_u:object_r:proc_t:s0 tclass=file

The program does continue on and exit cleanly, so it doesn't seem to
strictly require the access.

Does anyone know why Python is trying to access this file, or what
functionality I might be missing if I don't allow the access?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
