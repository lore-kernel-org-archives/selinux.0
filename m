Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA01044
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2002 06:38:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA28358
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2002 10:37:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA28354 for <selinux@tycho.nsa.gov>; Fri, 10 May 2002 10:37:41 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 9A32192452
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2002 20:38:41 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 30FF4C30
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2002 20:38:04 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: 2002050211
Date: Fri, 10 May 2002 20:38:03 +1000
MIME-Version: 1.0
Message-Id: <20020510103804.30FF4C30@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just uploaded Debian packages of the 2002050211 release to Debian and to 
my own site.

One change that I have made to the macros is the following.  It has no impact 
on anyone using the macro (the daemon_domain macro does the same as before), 
but I have a need for the same macro but without any use of var_run.

Also I'm getting married tomorrow, so I won't be reading email for 2 weeks.

#######################
# daemon_base_domain(domain_prefix)
#
# Define a daemon domain with a base set of type declarations
# and permissions that are common to most daemons.
#
# Author:  Russell Coker <russell@coker.com.au>
#
define(`daemon_base_domain', `
type $1_t, domain, privlog;
type $1_exec_t, file_type, sysadmfile, exec_type;

role system_r types $1_t;

domain_auto_trans(initrc_t, $1_exec_t, $1_t)

# Inherit and use descriptors from init.
allow $1_t { init_t newrole_t }:fd use;
allow $1_t { init_t newrole_t }:process sigchld;
allow $1_t self:process signal_perms;

uses_shlib($1_t)

allow $1_t self:process fork;
allow $1_t null_device_t:chr_file rw_file_perms;
')dnl

define(`daemon_domain', `
daemon_base_domain($1)
# Create pid file.
type var_run_$1_t, file_type, sysadmfile, pidfile;
file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
')dnl

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
