Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o22N7jN3002474
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 18:07:45 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o22N85DA014794
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 23:08:07 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B55C3180C0
	for <selinux@tycho.nsa.gov>; Wed,  3 Mar 2010 10:07:37 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: squid and apache
Date: Wed, 3 Mar 2010 10:07:33 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003031007.35281.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

apache_content_template(squid)

squid.te has the above in an optional section.

/usr/lib/squid/cachemgr\.cgi -- 
gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)

squid.fc has the above, but there is no facility for optional sections in fc 
files.

How should we solve this?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
