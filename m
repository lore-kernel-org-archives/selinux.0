Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43C0RRb004368
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 08:00:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43BwDZx005320
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 11:58:13 GMT
Received: from ensi-bourges.fr (ldap.ensi-bourges.fr [194.206.83.68])
	by jazzswing.ncsc.mil  with ESMTP id i43BwCJv005315
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 11:58:12 GMT
Received: from unknown (HELO virus.ensi-bourges.fr) ([172.20.128.204])
          (envelope-sender <maxence.bernard@ensi-bourges.fr>)
          by ldap.ensi-bourges.fr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 3 May 2004 12:53:41 -0000
Message-ID: <40786.172.20.128.112.1083588820.squirrel@ldap.ensi-bourges.fr>
Date: Mon, 3 May 2004 12:53:40 -0000 (UTC)
Subject: build script problem : sed command error
From: maxence.bernard@ensi-bourges.fr
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I work in a project of secured clusters.
When I launch the script build, I have one error with the sed command.
Please look at the error :



+ cd policy-1.10
+ exit 0
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd policy-1.10
+ mv domains/misc/unused/auth-net.te domains/misc/unused/fcron.te
domains/misc/unused/startx.te domains/misc
+ mv domains/program/unused/sendmail.te domains/program/
+ cd domains/program/
+ mv dpkg.te gatekeeper.te qmail.te xprint.te uml_net.te tinydns.te unused/
+ make policy
+ exit 0
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd policy-1.10
+ rm -rf /var/tmp/policy-buildroot
+ mkdir -p /var/tmp/policy-buildroot/etc/security/
+ mkdir -p /var/tmp/policy-buildroot/etc/security/selinux
+ make DESTDIR=/var/tmp/policy-buildroot install
sed: -e expression #1, char 132: Unknown option to 's'
Usage: /usr/sbin/genhomedircon POLICYSOURCEDIR FILE_CONTEXTS
make: *** [file_contexts/file_contexts] Erreur 1
error: Bad exit status from /var/tmp/rpm-tmp.3423 (%install)
    Bad exit status from /var/tmp/rpm-tmp.3423 (%install)


Has someone met the same problem ?

Thank you in advance.

Maxence

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
