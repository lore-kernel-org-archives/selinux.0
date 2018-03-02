Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w22Io9Hn020571
 for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2018 13:50:09 -0500
Received: by mail-qk0-f175.google.com with SMTP id f25so13189368qkm.0
 for <selinux@tycho.nsa.gov>; Fri, 02 Mar 2018 10:49:10 -0800 (PST)
Received: from [192.168.1.190] ([69.140.143.28])
 by smtp.gmail.com with ESMTPSA id t56sm5111097qte.53.2018.03.02.10.49.09
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Mar 2018 10:49:09 -0800 (PST)
To: selinux@tycho.nsa.gov
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
Date: Fri, 2 Mar 2018 13:49:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: libsepol policycap names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've been able to make SETools dynamically link to libsepol.  However, 
one challenge is with policycap names.  They're static libsepol, with 
nothing that exports them.  Can we either:

* export the sepol_polcap_getname() function, or
* move the polcap_names[] in polcaps.c into <sepol/policydb/polcaps.h> ?

Then I can avoid having to manually keep a polcap name list inside SETools.

-- 
Chris PeBenito
