Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3HM2HKp024117
 for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2017 18:02:17 -0400
Received: by mail-oi0-f52.google.com with SMTP id r203so156908831oib.3
 for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2017 15:02:16 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-136-2.tx.res.rr.com. [70.119.136.2])
 by smtp.gmail.com with ESMTPSA id
 h2sm5289519ote.46.2017.04.17.15.02.15 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Apr 2017 15:02:15 -0700 (PDT)
To: selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Cannot write policy to allow { relabelto }
Message-ID: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
Date: Mon, 17 Apr 2017 17:02:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am having a weird problem writing a policy for a service.  The service
needs to set SELinux file contexts, so I've created a rule to allow
this:

allow acme_nss_t cert_t : file { read write create getattr setattr
relabelfrom relabelto open } ;

Despite this, I am still getting this denial:

avc:  denied  { relabelto } for  pid=3561 comm="update-mod-nss"
name="cert8.db" dev="dm-0" ino=50343845
scontext=system_u:system_r:acme_nss_t:s0
tcontext=unconfined_u:object_r:cert_t:s0 tclass=file

Any ideas?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
