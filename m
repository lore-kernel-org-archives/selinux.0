Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2GMinx6024789
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 17:44:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05626
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 22:41:23 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id WAA05622
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 22:41:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 57F04BF42
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:44:44 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 16154-06
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:44:43 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 097ADBF41
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:44:43 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6419B9253C
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:44:44 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 17EA02C2D
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 23:44:35 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new snort policy
Date: Sun, 16 Mar 2003 23:44:34 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_S5Pd+hvTR3B6mNM"
Message-Id: <200303162344.34427.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_S5Pd+hvTR3B6mNM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Someone reported some problems with the snort policy so I re-wrote it to use 
the daemon_domain macro.  It's now smaller, simpler, and works better.

Please merge it in the CVS tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_S5Pd+hvTR3B6mNM
Content-Type: text/plain;
  charset="us-ascii";
  name="snort.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="snort.te"

#DESC Snort - Network sniffer
#
# Author: Shaun Savage <savages@pcez.com> 
# Modified by Russell Coker <russell@coker.com.au>
#

daemon_domain(snort)

log_domain(snort)
can_network(snort_t)
type snort_etc_t, file_type, sysadmfile;

# Create temporary files.
tmp_domain(snort)

# use iptable netlink
allow snort_t self:netlink_socket create_socket_perms;
allow snort_t self:packet_socket create_socket_perms;
allow snort_t self:capability { setgid setuid net_admin net_raw };

r_dir_file(snort_t, snort_etc_t)
allow snort_t etc_t:file { getattr read };
allow snort_t etc_t:lnk_file read;

allow snort_t self:unix_dgram_socket create_socket_perms;
allow snort_t self:unix_stream_socket create_socket_perms;

# for start script
allow initrc_t snort_etc_t:file read;

--Boundary-00=_S5Pd+hvTR3B6mNM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
