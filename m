Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j19L9wL9007978
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 16:09:58 -0500 (EST)
Received: from continuum.cm.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j19L7ZQY012462
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 21:07:35 GMT
Received: from shane by continuum.cm.nu with local (Exim 4.34)
	id 1Cyz5p-0005PM-CE
	for selinux@tycho.nsa.gov; Wed, 09 Feb 2005 13:09:49 -0800
Date: Wed, 9 Feb 2005 13:09:49 -0800
From: Shane <shane-keyword-selinux.9d5a25@cm.nu>
To: selinux@tycho.nsa.gov
Subject: Error installing Debian selinux-policy-default package
Message-ID: <20050209210949.GA8529@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello list,

I am getting this error when installing
selinux-policy-default from Debian unstable.

Installing the new SE Linux policy
mount: none already mounted or /selinux busy
dpkg: error processing selinux-policy-default
(--configure):
 subprocess post-installation script returned error exit
status 32
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)
Ack!  Something bad happened while installing packages. 
Trying to recover:
Setting up selinux-policy-default (1.18-1) ...
/usr/bin/checkpolicy:  loading policy configuration from
policy.conf
domains/user.te:92:ERROR 'unknown type user_xserver_tmp_t'
at token ';' on line 19375:
allow user_uml_t user_xserver_tmp_t:sock_file write;
#line 92
/usr/bin/checkpolicy:  error(s) encountered while parsing
configuration
make: *** [/etc/selinux/policy/policy.18] Error 1
run-parts: /etc/dpkg/postinst.d/selinux exited with return
code 2
"/bin/run-parts --arg=selinux-policy-default
/etc/dpkg/postinst.d" failed: 256
dpkg: error processing selinux-policy-default
(--configure):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default

domains/user.te line 92 says:
full_user_role(user)

which I assume is some sort of macro.  Thing is, I said no
to both uml and xserver in the policy selection
configurator as this machine has neither installed.

Best regards,
Shane
-- 
Shane Wegner
http://www.cm.nu/~shane/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
