Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j233IBDo013504
	for <selinux@tycho.nsa.gov>; Wed, 2 Mar 2005 22:18:11 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j233C1YA011443
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2005 03:12:01 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j233EPTI022602
	for <selinux@tycho.nsa.gov>; Wed, 2 Mar 2005 22:14:26 -0500 (EST)
Subject: x_client_domain: reducing privileges - suspect rules
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 02 Mar 2005 22:17:56 -0500
Message-Id: <1109819880.17743.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Which of those rules (taken from x_client_domain) has to do
_specifically_ with connecting to the X server, and which is there for
no good reason and should be removed? I have a hard time believing
_all_ of this is absolutely necessary. I can remove rules and test
if things break if you're not sure. The idea is to decouple
"general-domain" style functionality from the things necessary to
connect to X, which I think should be the theme for this domain/macro.

I see a lot of overlap with general_domain_access, but a lot is
different too. 

# This domain is granted permissions common to most domains (including
can_net)
can_network($1_$2_t)
can_ypbind($1_$2_t)
allow $1_$2_t self:process { fork signal_perms getsched };
allow $1_$2_t self:unix_dgram_socket create_socket_perms;
allow $1_$2_t self:unix_stream_socket { connectto
create_stream_socket_perms };
allow $1_$2_t self:fifo_file rw_file_perms;
allow $1_$2_t etc_runtime_t:file { getattr read };
allow $1_$2_t etc_t:lnk_file read;
allow $1_$2_t fs_t:filesystem getattr;
access_terminal($1_$2_t, $1)
read_locale($1_$2_t)
r_dir_file($1_$2_t, readable_t)
allow $1_$2_t proc_t:dir search;
allow $1_$2_t proc_t:lnk_file read;
allow $1_$2_t self:dir search;
allow $1_$2_t self:lnk_file read;
read_sysctl($1_$2_t)

# allow using shared libraries and running programs
uses_shlib($1_$2_t)
allow $1_$2_t { bin_t sbin_t }:dir search;
allow $1_$2_t bin_t:lnk_file read;
can_exec($1_$2_t, { shell_exec_t bin_t })
allow $1_$2_t etc_t:file { getattr read };


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
