Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h914xZsJ022913
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 00:59:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h914xYCG021890
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 04:59:34 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h914xXqJ021887 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 04:59:34 GMT
Subject: file_labels_t
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1064984367.1511.30.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Tue, 30 Sep 2003 23:59:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was doing some cleaning (goodbye devfsd.{te.fc}), and I was thinking
that file_labels_t could be removed in new api policy, since psid is
gone.  However, when I was going through looking for the rules that had
it, I realized that it is still an initial sid.  Why is the initial sid
still around if psid is gone?  Because it requires a bit of a kernel
modification?

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
