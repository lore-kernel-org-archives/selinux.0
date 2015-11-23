Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAN0rGAj013505
 for <selinux@tycho.nsa.gov>; Sun, 22 Nov 2015 19:53:16 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id E16051A1D8
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 01:53:07 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id OVQP7p4dkNwH for <selinux@tycho.nsa.gov>;
 Mon, 23 Nov 2015 01:53:04 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1::6b5] (unknown
 [IPv6:2a02:578:85fc:1::6b5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 5EBDC1A070
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 01:53:04 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: (Userspace) AVC denial generated even if allowed by the policy?
Message-ID: <5652636F.2060609@debian.org>
Date: Mon, 23 Nov 2015 01:53:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I'm still looking at adding SELinux support in the "at" daemon and I now 
have the following patch[0].

With this patch, at seems to behave like the cron daemon, as explained 
in the commit log:

     - When cron_userdomain_transition is set to off, a process for an
       unconfined user will transition to unconfined_cronjob_t. For confined
       user, the job is run as cronjob_t.

     - When cron_userdomain_transition is set to on, the processes are run
       under the user default context.

But every time an AVC denial is generated (with 
cron_userdomain_transition set to off and the user running as staff_u, 
in permissive with unmodified refpolicy):

avc:  denied  { entrypoint } for scontext=staff_u:staff_r:cronjob_t:s0 
tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file

The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0

But audit2{allow,why} are saying that this is already allowed in the policy

Setting the cron_userdomain_transition boolean to on, I have the 
following avc:

avc:  denied  { entrypoint } for scontext=staff_u:sysadm_r:sysadm_t:s0 
tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file

The job runs as (id -Z): staff_u:sysadm_r:sysadm_t:s0

So as said it seems to work, but I'm not sure why this AVC denial is 
generated.

sesearch shows:

$ sesearch -ATSC  -t user_cron_spool_t -c file -p entrypoint
Found 6 semantic av rules:
    allow files_unconfined_type file_type : file { ioctl read write 
create getattr setattr lock relabelfrom relabelto append unlink link 
rename execute swapon quotaon mounton execute_no_trans entrypoint open 
audit_access } ;
DT allow unconfined_t user_cron_spool_t : file entrypoint ; [ 
cron_userdomain_transition ]
DT allow user_t user_cron_spool_t : file entrypoint ; [ 
cron_userdomain_transition ]
EF allow cronjob_t user_cron_spool_t : file entrypoint ; [ 
cron_userdomain_transition ]
DT allow staff_t user_cron_spool_t : file entrypoint ; [ 
cron_userdomain_transition ]
DT allow sysadm_t user_cron_spool_t : file entrypoint ; [ 
cron_userdomain_transition ]

Did I overlooked something?

Cheers,

Laurent Bigonville

[0] 
https://anonscm.debian.org/cgit/users/bigon/at.git/commit/?h=selinux&id=0112f006b74a36f7200e315575fd25d78e11b170 
