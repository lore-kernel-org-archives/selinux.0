Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i733InrT018045
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 23:18:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i733IEXV028845
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 03:18:15 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6383561BD2
	for <selinux@tycho.nsa.gov>; Tue,  3 Aug 2004 13:18:37 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07874-09 for <selinux@tycho.nsa.gov>;
	Tue, 3 Aug 2004 13:18:37 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E69C861BBE
	for <selinux@tycho.nsa.gov>; Tue,  3 Aug 2004 13:18:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8F0C5B59A7
	for <selinux@tycho.nsa.gov>; Tue,  3 Aug 2004 13:18:35 +1000 (EST)
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: postgrey policy
Date: Tue, 3 Aug 2004 13:18:34 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KQwDBIidJZizWWd"
Message-Id: <200408031318.34469.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_KQwDBIidJZizWWd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is policy for the postgrey daemon for grey-listing in Postfix.

Grey-listing means giving a 45x code in response to email the first time a 
particular IP address or combination of IP address and email address attempts 
to send mail to you.  Some minutes later the mail will be received.

Spam machines generally don't re-try so greylisting stops lots of spam, and as 
long as the delay is significantly less than 4 hours (usually only a few 
minutes) someone who sends legit email will never notice any difference.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_KQwDBIidJZizWWd
Content-Type: text/plain;
  charset="us-ascii";
  name="postgrey.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="postgrey.fc"

# postgrey - postfix grey-listing server
/usr/sbin/postgrey	--	system_u:object_r:postgrey_exec_t
/var/run/postgrey\.pid	--	system_u:object_r:postgrey_var_run_t
/etc/postgrey(/.*)?		system_u:object_r:postgrey_etc_t
/var/lib/postgrey(/.*)?		system_u:object_r:postgrey_var_lib_t

--Boundary-00=_KQwDBIidJZizWWd
Content-Type: text/plain;
  charset="us-ascii";
  name="postgrey.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="postgrey.te"

#DESC postgrey - Postfix Grey-listing server
#
# Author:  Russell Coker <russell@coker.com.au>
# X-Debian-Packages: postgrey

daemon_domain(postgrey)

allow postgrey_t urandom_device_t:chr_file { getattr read };

# for perl
allow postgrey_t sbin_t:dir search;
allow postgrey_t usr_t:{ file lnk_file } { getattr read };
dontaudit postgrey_t usr_t:file ioctl;

allow postgrey_t { etc_t etc_runtime_t }:file { getattr read };
etcdir_domain(postgrey)

can_network(postgrey_t)
allow postgrey_t self:unix_stream_socket create_stream_socket_perms;
allow postgrey_t proc_t:file { getattr read };

allow postgrey_t self:capability { chown setuid };

var_lib_domain(postgrey)

allow postgrey_t tmp_t:dir getattr;

--Boundary-00=_KQwDBIidJZizWWd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
