Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA15277
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 02:15:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA14094
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 07:12:00 GMT
Received: from kjist.ac.kr (eunhasu.kjist.ac.kr [203.237.32.200])
	by jazzswing.ncsc.mil  with ESMTP id HAA14090
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 07:11:59 GMT
Received: from unknown (HELO kari) (kimhc@[203.237.51.114])
          (envelope-sender <kimhc@kjist.ac.kr>)
          by eunhasu.kjist.ac.kr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 10 Feb 2003 16:09:51 +0900
Message-ID: <002e01c2d0d3$f2a2fd40$7233edcb@kari>
From: "Kim Hyung Chan" <kimhc@kjist.ac.kr>
To: <selinux@tycho.nsa.gov>
Subject: question about role dominance relation ...
Date: Mon, 10 Feb 2003 16:13:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi~ All!!

Configuring role dominance relations,

dominance { role A; role B; }
In this case, what role dominates the other role??

And I also want to see an example, saying
"A role A dominates a set of roles B, C..."

Thanks ahead...

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Hyung Chan Kim

Security Group, Concurrent System Research Laboratory
Dept. of Information and Communications
Kwangju Institute of Science and Technology (K-JIST)
1 Oryong-dong Buk-ku Gwangju 500-712, Rep. of Korea

Lab. : +82-62-970-2266
Fax : +82-62-970-2204
Mobile : +82-11-9660-4900
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
