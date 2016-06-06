Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u56Lj6BE015899
 for <selinux@tycho.nsa.gov>; Mon, 6 Jun 2016 17:45:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.vivaldi.net (Postfix) with ESMTP id 26CF2432
 for <selinux@tycho.nsa.gov>; Mon,  6 Jun 2016 21:45:03 +0000 (GMT)
Received: from mail.vivaldi.net ([127.0.0.1])
 by localhost (mail.vivaldi.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jMqY47Cm_1d for <selinux@tycho.nsa.gov>;
 Mon,  6 Jun 2016 21:45:00 +0000 (GMT)
Received: from mail.vivaldi.net (localhost [IPv6:::1])
 (Authenticated sender: john.chludzinski)
 by mail.vivaldi.net (Postfix) with ESMTPA id DC9443F6
 for <selinux@tycho.nsa.gov>; Mon,  6 Jun 2016 21:45:00 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 06 Jun 2016 17:45:00 -0400
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: Selinux <selinux@tycho.nsa.gov>
Subject: Problem building CLIP ISO
Message-ID: <17ff81b08dae0262ca3caa4ee4c4e516@mail.vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I ran:

$ git clone -b CLIP_RHEL_7.0_Final 
https://github.com/TresysTechnology/clip.git

As root, I ran:

$ ./bootstrap.sh

and got ...

<username> cannot register with any organizations.

So I tried:

$ subscription-manager register --username <username> --password 
<passwor> --auto-attach

and got ...

<username> cannot register with any organizations.


What's the solution?


---John
