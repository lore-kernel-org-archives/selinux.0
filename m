Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HLn3Rb027375
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 17:49:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4HLn1AR014686
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:49:01 GMT
Received: from hafnium.btinternet.com (hafnium.btinternet.com [194.73.73.121])
        by jazzband.ncsc.mil  with ESMTP id i4HLn0Hn014683 for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:49:00 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by hafnium.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BPpym-0001Bd-00
	for selinux@tycho.nsa.gov; Mon, 17 May 2004 22:49:00 +0100
Received: from highfield ([192.168.0.223]:33965 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BPq1W-00076c-Lz
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:51:50 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BPpwH-0002qL-Df
	for selinux@tycho.nsa.gov; Mon, 17 May 2004 21:46:25 +0000
Date: Mon, 17 May 2004 21:46:25 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: error on build of latest cvs (head) selinux-usr/policy
Message-ID: <20040517214625.GV9378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

bug-report time!

i get the following message:

mkdir -p /etc/security/selinux
/usr/bin/checkpolicy -o /etc/security/selinux/policy.15 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
ERROR 'syntax error' at token 'typealias' on line 2764:
typealias net_conf_t alias resolv_conf_t;
type net_conf_t, file_type, sysadmfile;
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration

i also had to add:

$(ROOTDIR)/.default_contexts: appconfig/root_default_contexts
        mkdir -p $(ROOTDIR)
		install -m 644 $< $@

mkdir -p because otherwise the file doesn't get copied because
the directory doesn't exist.

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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
