Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NLllrT021725
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:47:47 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NLl1AS002686
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:47:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 5BC35BF95
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:47:46 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 28579-07 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 22:47:44 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 05ECCBF8A
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:47:43 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzMqG-0003bN-43
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 22:59:04 +0100
Date: Mon, 23 Aug 2004 22:59:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch for ssh-agent
Message-ID: <20040823215904.GE13677@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gMR3gsNFwZpnI/Ts"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

absolutely clueless as to what this is for, but at least it gets
rid of the audit warnings, which were bugging me.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ssh_agent

diff -Naur 
--- default.1.14/macros/program/ssh_agent_macros.te	2004-08-02 08:28:37.000000000 +0100
+++ current/macros/program/ssh_agent_macros.te	2004-08-14 23:34:48.000000000 +0100
@@ -86,7 +86,10 @@
 
 ifdef(`xdm.te', `
 allow $1_ssh_agent_t xdm_t:fd { use };
-allow $1_ssh_agent_t xdm_t:fifo_file { write };
+allow $1_ssh_agent_t xdm_t:fifo_file { read write };
+
+# kdm: sigchld
+allow $1_ssh_agent_t xdm_t:process { sigchld };
 ')
 
 #
@@ -103,5 +106,17 @@
 allow $1_ssh_t $1_tmp_t:sock_file write;
 allow $1_ssh_t $1_t:unix_stream_socket connectto;
 allow $1_ssh_t sshd_t:unix_stream_socket connectto;
+
+dontaudit $1_ssh_agent_t selinux_config_t:file { getattr read };
+	#EXE=/usr/bin/ssh-agent  NAME=config   :  read
+	#EXE=/usr/bin/ssh-agent  PATH=/etc/selinux/config   :  getattr
+
+allow $1_ssh_agent_t self:dir { search };
+	#EXE=/usr/bin/ssh-agent  NAME=2971   :  search
+
+allow $1_ssh_agent_t self:file { getattr read };
+	#EXE=/usr/bin/ssh-agent  NAME=mounts   :  read
+	#EXE=/usr/bin/ssh-agent  PATH=/proc/2971/mounts   :  getattr
+
 ')dnl end if ssh_agent
 

--gMR3gsNFwZpnI/Ts--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
