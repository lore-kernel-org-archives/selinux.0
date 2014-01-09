Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09GbovE002489
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 11:37:50 -0500
Received: from web11j.yandex.ru (web11j.yandex.ru [5.45.198.52])
 by forward15.mail.yandex.net (Yandex) with ESMTP id C47149E1C3C
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 20:37:41 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: selinux@tycho.nsa.gov
Subject: Restrict to a fixed Internet domain in a sandbox
MIME-Version: 1.0
Message-Id: <23731389285461@web11j.yandex.ru>
Date: Thu, 09 Jan 2014 18:37:41 +0200
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I remind that sandbox is implemented in Fedora using SELinux.

It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).

It seems it is impossible with current SELinux.

Could you add necessary features? Please!

-- 
Victor Porton - http://portonvictor.org
