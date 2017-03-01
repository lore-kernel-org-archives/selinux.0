Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21Lf0H9020564
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 16:41:00 -0500
Received: by mail-ot0-f171.google.com with SMTP id x10so39539638otb.1
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 13:40:51 -0800 (PST)
To: selinux@tycho.nsa.gov
Cc: Systemd <systemd-devel@lists.freedesktop.org>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: SELinux type transition rule not working
Message-ID: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
Date: Wed, 1 Mar 2017 15:40:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am using systemd's RuntimeDirectory to create a directory for a
service.

    RuntimeDirectory=squoxy

This causes systemd to create /run/squoxy before starting my service,
but I haven't been able to get the SELinux context set correctly on the
directory.

I've set file context rules for both /run/squoxy and /var/run/squoxy:

^/var/run/squoxy(/.*)?  all files  system_u:object_r:squoxy_var_run_t:s0
^/run/squoxy(/.*)?      all files  system_u:object_r:squoxy_var_run_t:s0

And, indeed, restorecon will set the context of the directory to
squoxy_var_run_t.

I've also added a type transition rule, attempting to get the correct
context applied automatically when systemd creates the directory:

type_transition init_t var_run_t : dir squoxy_var_run_t "squoxy";

But the directory is still being created as var_run_t:

drwxr-xr-x. nobody nobody system_u:object_r:var_run_t:s0   /run/squoxy

What am I doing wrong?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
