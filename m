Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19264
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 10:23:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA28002
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 15:23:51 GMT
Received: from jsmith.org (pool-141-158-40-242.phil.east.verizon.net [141.158.40.242])
	by jazzswing.ncsc.mil  with ESMTP id PAA27998
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 15:23:50 GMT
Subject: policy additions needed to make my system run in secure mode
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 01 Dec 2001 10:21:26 -0500
Message-Id: <1007220086.2747.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



These are lines of text I had to ADD to the default NSA policy to
allow my system to boot and run its normal functions in secure mode:


(I haven't tested X windows and my usual desktop environment yet, 
so there may be more such additions...)
------------------------------------------------------------------------
initrc.te:

# ipchains
allow initrc_t initrc_t:rawip_socket { create setopt };

# usb

allow initrc_t unlabeled_t:dir { search };
allow initrc_t unlabeled_t:file { read getattr };
allow mount_t usr_t:dir { mounton };
allow mount_t usr_t:file { append setattr };
allow mount_t proc_t:dir { mounton };


# postgres

allow initrc_t user_home_t:dir { append };
allow initrc_t user_home_t:file { append };
allow initrc_t var_lib_t:dir { write add_name create };
allow initrc_t var_lib_t:file { create };
allow initrc_t tmpfs_t:file { read write };
--------------------------------------------------------------------------
apache.te:

# General (allow server-side includes)

allow httpd_t httpd_user_script_rw_t:file { getattr read };

#
# Servlets
# (I modified file types to make all my web pages t
#  httpd_user_script_rw_t
# and the Tomcat servlet directory to httpd_user_script)
#

allow httpd_t httpd_user_script_t:file { append };
allow initrc_t httpd_user_script_rw_t:dir 
       { getattr search };

allow httpd_t httpd_user_script_rw_t:dir 
       { search getattr };
allow initrc_t httpd_user_script_rw_t:file 
       { read getattr append write };

allow initrc_t httpd_user_script_t:dir { read write };
allow initrc_t httpd_user_script_t:file 
       { read write execute execute_no_trans setattr append };
allow initrc_t file_t:lnk_file { read };
allow initrc_t file_t:file { execute execute_no_trans };
allow initrc_t usr_t:file { execute execute_no_trans };
allow initrc_t http_port_t:tcp_socket { name_bind };
--------------------------------------------------------------

user.te:

# Postgres

allow user_t usr_t:file { execute execute_no_trans };
allow user_t initrc_tmp_t:sock_file { write };
allow user_t initrc_t:unix_stream_socket { connect };

----------------------------------------------------------

These may not be ideal from a security point of view but they work.

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
