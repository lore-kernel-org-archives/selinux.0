Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56GGRrT029824
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 12:16:27 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i56GGN22013356
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 12:16:23 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 16:16:11 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWzfb-00015q-Eb
	for selinux@tycho.nsa.gov; Sun, 06 Jun 2004 15:34:47 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BX0H7-0005sz-By
	for selinux@tycho.nsa.gov; Sun, 06 Jun 2004 16:13:33 +0000
Date: Sun, 6 Jun 2004 16:13:33 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fireflier (cool firewall program) policy files
Message-ID: <20040606161333.GI10890@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

fireflier is a client-server architecture firewall program that uses
ip queueing to block packets until you've approved or rejected them.

only used it the once and love it already: you can set it to approve
packets on a per-program-name basis as well which i persn'y really
like.

my bug-bear with the program and the corresponding policy i had to
create is that it demands to know the names of all programs it
could possibly want to tell you about, and so it does a quite
extensive directory search.

therefore i added the last two lines as an "afterthought".

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fireflier.fc"

# fireflier firewall
/usr/sbin/fireflierd		--	system_u:object_r:fireflier_exec_t
/etc/fireflier(/.*)?			system_u:object_r:fireflier_etc_t
/etc/fireflier/fireflier.conf	--	system_u:object_r:fireflier_conf_t
/var/lib/fireflier(/.*)?		system_u:object_r:fireflier_var_lib_t

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fireflier.te"

#DESC FireFlier - Firewall Server
#
# Author:  Luke Kenneth Casson Leighton <lkcl@lkcl.net>
# X-Debian-Packages: fireflier-server, fireflier-client-kde
#


daemon_domain(fireflier)

can_network(fireflier_t)
logdir_domain(fireflier)

type fireflier_conf_t, file_type, sysadmfile;
type fireflier_etc_t, file_type, sysadmfile;
type fireflier_var_lib_t, file_type, sysadmfile;

domain_auto_trans(initrc_t, fireflier_exec_t, fireflier_t)

#allow fireflier_t self:capability { net_admin net_bind_service };
file_type_auto_trans(fireflier_t, etc_t, fireflier_etc_t, file)
file_type_auto_trans(fireflier_t, fireflier_etc_t, fireflier_conf_t, file)
file_type_auto_trans(fireflier_t, var_run_t, fireflier_var_run_t, sock_file)
file_type_auto_trans(fireflier_t, var_lib_t, fireflier_var_lib_t, file)

# startup script /etc/init.d/fireflier needs to read the config file
allow initrc_t fireflier_conf_t:file { read };

allow fireflier_t fireflier_t:unix_dgram_socket { getattr create connect write };
allow fireflier_t fireflier_t:netlink_socket { create bind write read getattr };
allow fireflier_t fireflier_t:unix_stream_socket { create connect };
allow fireflier_t port_t:tcp_socket { name_bind };

allow fireflier_t sbin_t:dir { search };
allow fireflier_t bin_t:dir { search };
allow fireflier_t iptables_exec_t:file { getattr execute execute_no_trans read };
allow fireflier_t var_lib_t:dir { search };
allow fireflier_t bin_t:lnk_file { read };
allow fireflier_t shell_exec_t:file { getattr execute execute_no_trans read };

allow fireflier_t fireflier_t:capability { net_admin net_raw };

allow fireflier_t etc_runtime_t:file { read getattr };
allow fireflier_t etc_t:file { read };
allow fireflier_t proc_t:file { read getattr };

allow fireflier_t fireflier_var_lib_t:dir { add_name search write };

allow fireflier_t fireflier_t:rawip_socket { create getopt setopt };
allow fireflier_t sysctl_modprobe_t:file { read };

allow fireflier_t insmod_exec_t:file { execute execute_no_trans };

# this is *sigh* to allow the daemon to read program names
# so that it can tell users what program is doing network access.
allow fireflier_t default_t:dir r_dir_perms;
allow fireflier_t default_t:notdevfile_class_set r_file_perms;


--u3/rZRmxL6MmkK24--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
