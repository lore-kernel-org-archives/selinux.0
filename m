Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43CrmRb004739
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 08:53:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43CpYZx008136
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 12:51:34 GMT
Received: from ensi-bourges.fr (ldap.ensi-bourges.fr [194.206.83.68])
	by jazzswing.ncsc.mil  with ESMTP id i43CpXJv008133
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 12:51:33 GMT
Received: from unknown (HELO virus.ensi-bourges.fr) ([172.20.128.204])
          (envelope-sender <amine.baina@ensi-bourges.fr>)
          by ldap.ensi-bourges.fr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 3 May 2004 13:47:01 -0000
Message-ID: <34102.172.20.128.112.1083592021.squirrel@ldap.ensi-bourges.fr>
Date: Mon, 3 May 2004 13:47:01 -0000 (UTC)
Subject: selinux + pb : libselinux.so.1 not found 
From: amine.baina@ensi-bourges.fr
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello everybody,

I have some problems in installing selinux on Mandrake clic 9.1

when I launch sh ./build
I have the error : libselinux.so.1 not found

I think I should download libselinux rpm and install it to solve
the problem, because it provides libselinux.so.1 which is the origin
of the problem

I hope somebody could help me ]:-D

A.B

+ cd /usr/src/RPM/BUILD
+ rm -rf libselinux-1.10
+ /bin/gzip -dc /usr/src/selinux-usr/libselinux-1.10.tgz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd libselinux-1.10
+ exit 0
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd libselinux-1.10
+ make
cc: libselinux.so.1: No such file or directory
make[1]: *** [libselinux.so.1] Erreur 1
make: *** [all] Erreur 2
error: Bad exit status from /var/tmp/rpm-tmp.96765 (%build)
    Bad exit status from /var/tmp/rpm-tmp.96765 (%build)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
