Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBIIjtja031744
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 13:45:55 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBIIjrTS005547
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 18:45:54 GMT
Received: from [IPv6:2001:6f8:900:6e8::2] (cl-1769.ham-01.de.sixxs.net [IPv6:2001:6f8:900:6e8::2])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id lBIIjKkF026223
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 19:45:47 +0100
Subject: Propper labeling of files under /var/www
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 18 Dec 2007 18:45:07 +0000
Message-Id: <1198003507.3705.15.camel@localhost6.localdomain6>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How do you label files under /var/www? I created a policy with the
following context

/var/www/wiki(/.*)?
gen_context(system_u:object_r:httpd_wiki_script_ro_t,s0)

Loaded the policy and relabeled /var/www but the context
of /var/www/wiki is still httpd_sys_content_t. Checked the
file /etc/selinux/targeted/contexts/files/file_contexts twice and the
entry for /var/www/wiki exists (it's under the /var/www entry). The
relabel was done via fixfiles and restorecon and even a reboot
(touch /.autorelabel).

I'm out of ideas ;-) Any suggestions?

Best regards
Stefan

PS: I'm using Fedora 7 (latest updates) with the targeted policy
(2.6.4-61.fc7)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
