Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4GCE4u8016586
 for <selinux@tycho.nsa.gov>; Fri, 16 May 2014 08:14:04 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so1510780eek.12
 for <selinux@tycho.nsa.gov>; Fri, 16 May 2014 05:14:04 -0700 (PDT)
Received: from [192.168.1.100] ([84.245.1.4])
 by mx.google.com with ESMTPSA id a4sm19669007eep.12.2014.05.16.05.14.03
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Fri, 16 May 2014 05:14:03 -0700 (PDT)
Message-ID: <1400242442.444.9.camel@x220.localdomain>
Subject: secilc: classmappings do not work
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Fri, 16 May 2014 14:14:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I wanted to try out some of the less common features of cil after
studying the cil reference guide but its been a bumpy ride.

Anyhow classmappings do not work

I have for example this one

(clasmap dirs (list))

(classmapping dirs list
    read_lnk_file_perms
    list_dir_perms
)

The read_lnk_file_perms and list_dir_perms are classpermissionsets
(which work nicely)

Only the first entry works (in this example read_lnk_file_perms)
The other entries (like in this example list_dir_perms) do not make it
to the resulting policy

I have also tried this with straight rules instead of
classpermissionsets (same result)
