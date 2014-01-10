Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AJPqxF024058
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 14:25:52 -0500
From: Victor Porton <porton@narod.ru>
To: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Create new NetFilter table
MIME-Version: 1.0
Message-Id: <1171389381947@web15m.yandex.ru>
Date: Fri, 10 Jan 2014 21:25:47 +0200
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I propose to create a new NetFilter table dedicated to rules created programmatically (not by explicit admin's iptables command).

Otherwise an admin could be tempted to say `iptables -F security` which would probably break rules created for example by sandboxing software (which may follow same-origin policy to restrict one particular program to certain domain and port only). Note that in this case `iptables -F security` is a security risk (sandbox breaking)?

New table could be possibly be called:

- temp
- temporary
- auto
- automatic
- volatile
- daemon
- system
- sys

In iptables docs it should be said that this table should not be manipulated manually.

-- 
Victor Porton - http://portonvictor.org
