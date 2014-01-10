Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AIuKGJ022157
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 13:56:21 -0500
Received: from web5j.yandex.ru (web5j.yandex.ru [5.45.198.46])
 by forward11.mail.yandex.net (Yandex) with ESMTP id 10FF9E822A4
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 22:56:18 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: selinux@tycho.nsa.gov
Subject: Waiting for programs to stop
MIME-Version: 1.0
Message-Id: <70061389380178@web5j.yandex.ru>
Date: Fri, 10 Jan 2014 20:56:18 +0200
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I remind that we discuss sandboxing of untrusted programs.

My application needs to receive a signal when ALL direct and indirect children of a process (including this process itself) started in a sandbox exit (it should work even when they call setsid()).

Can this be done with the current kernel?

-- 
Victor Porton - http://portonvictor.org
