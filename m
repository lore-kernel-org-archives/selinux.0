Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB5EDRIt010499
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2007 09:13:27 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB5EDPwI018890
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2007 14:13:26 GMT
Date: Wed, 5 Dec 2007 15:13:24 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org
Subject: refpolicy HEAD, Debian, syslogd & setrlimit
Message-ID: <20071205141324.GA1211@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

audit(1196861341.205:26): avc:  denied  { setrlimit } for  pid=2160 comm="cron" scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=process

There is a content of /etc/pam.d/cron from my Debian Etch:

    #
    # The PAM configuration file for the cron daemon
    #
    
    @include common-auth
    auth       required   pam_env.so
    @include common-account
    @include common-session
    # Sets up user limits, please define limits for cron tasks
    # through /etc/security/limits.conf
    session    required   pam_limits.so

/etc/security/limits.conf

has only comment sections.

Can be rlimit allowed or should be solved this in some other way?
Thanks
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
