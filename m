Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2ExqRb014791
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 09:59:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2ExBp5002892
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:59:11 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB2ExAt0002882
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:59:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris Vanden Berghe <vbc@zurich.ibm.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default
Date: Wed, 3 Dec 2003 01:59:41 +1100
References: <3FCC831A.1070002@zurich.ibm.com>
In-Reply-To: <3FCC831A.1070002@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312030159.41676.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Dec 2003 23:18, Chris Vanden Berghe <vbc@zurich.ibm.com> wrote:
> dpkg --install
> /var/cache/apt/archives/selinux-policy-default_1%3a1.2.real-13_all.deb
> (Reading database ... 112169 files and directories currently installed.)
> Preparing to replace selinux-policy-default 1:1.2.real-13 (using
> .../selinux-policy-default_1%3a1.2.real-13_all.deb) ...
> Unpacking replacement selinux-policy-default ...
> Setting up selinux-policy-default (1.2.real-13) ...
> /etc/selinux does not exist, aborting!

/etc/selinux is a sym-link to /usr/share/selinux/policy/current/ and is 
created on installation of the selinux-policy-default package.

Did you remove and re-install the package?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
