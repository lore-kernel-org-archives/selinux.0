Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1REdvRb018375
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 09:39:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1REduQQ006081
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 14:39:56 GMT
Received: from curiango.ipen.br (curiango.ipen.br [200.136.52.46])
        by jazzband.ncsc.mil  with ESMTP id i1REdtP0006021 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 14:39:55 GMT
Received: from [10.0.7.45] (helo=voabaixo ident=mail)
	by curiango.ipen.br with esmtp (Exim 3.35 #1 (Debian))
	id 1Awj9I-0001ev-00
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 11:39:32 -0300
Received: from mario by voabaixo with local (Exim 3.36 #1 (Debian))
	id 1Awj9B-0006gN-00
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 11:39:25 -0300
Date: Fri, 27 Feb 2004 11:39:25 -0300
From: Mario Olimpio de Menezes <mario@curiango.ipen.br>
To: SELinux <selinux@tycho.nsa.gov>
Subject: accessing files under Linux and SELinux
Message-ID: <20040227143925.GA21866@curiango.ipen.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

  When accessing files under Linux, several checks will be done by 
  syscall ensuring the user has the rights to do.

  When accessing files under SELinux, additional checks (security
  context) will be done.

  Can I think of this as: "the minimum set will prevail".

  For example, I add a user with uid=gid=1000 to a system and then
  assign this user a system_r role. If I try to access /etc/shadow I'll
  be denied by the Linux checks and not SELinux checks.

  Is this correct? Am I getting the wrong picture here?

  Thanks,


-- 
Mario O.de Menezes, Ph.D.    "Many are the plans in a man's heart, but
    IPEN-CNEN/SP                is the Lord's purpose that prevails"
http://www.ipen.br/~mario                  Prov. 19.21
    

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
