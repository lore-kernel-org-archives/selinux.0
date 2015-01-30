Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0UGi1I4018160
 for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2015 11:44:01 -0500
Message-ID: <54CBB4CD.6060006@native-instruments.de>
Date: Fri, 30 Jan 2015 17:43:57 +0100
From: Andrew Holway <andrew.holway@native-instruments.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: virtualenv
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

We're using virtualenv so we can use weird and wonderful python 
libraries. In the process of writing the SELinux policy module we have 
found that the parent process is in the initrc_t domain rather than the 
desired myapp_t domain.

It seems the virtualenv parent process is not transitioning to the 
nativeapi_t domain because the shell command "source" is not a 
standalone executable therefore we cannot set this with the 
"nativeapi_exec_t" type label. Is there a way around that would be more 
elegant than using some kind of wrapper script?

Its a bit odd to me that the parent process can be in one domain and the 
children in another.

Thanks,

Andrew

        system_u:system_r:initrc_t:s0 4086
/usr/bin/sh -c source /var/lib/myapp/env/bin/activate && gunicorn ...
        system_u:system_r:myapp_t:s0 4091
\_ /var/lib/native-api/env/bin/python /var/lib/myapp/env/bin/gunicorn ...
        system_u:system_r:myapp_t:s0 4176
\_ /var/lib/native-api/env/bin/python 
/var/lib/native-api/env/bin/gunicorn ...
