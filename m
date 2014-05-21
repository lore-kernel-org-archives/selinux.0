Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4LGUJd5003751
 for <selinux@tycho.nsa.gov>; Wed, 21 May 2014 12:30:19 -0400
Received: by mail-ee0-f42.google.com with SMTP id d49so1841010eek.1
 for <selinux@tycho.nsa.gov>; Wed, 21 May 2014 09:30:04 -0700 (PDT)
Received: from [192.168.1.100] ([84.245.1.4])
 by mx.google.com with ESMTPSA id i2sm13058761eem.11.2014.05.21.09.30.03
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Wed, 21 May 2014 09:30:03 -0700 (PDT)
Message-ID: <1400689802.5957.5.camel@x220.localdomain>
Subject: secilc: in statement ordering limitations
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Wed, 21 May 2014 18:30:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I got a little carried away with block and in statements (to say the
least)

I hit a limitation were ordering of modules matters (e.g. ordering of
entries in LISTING or entries fed into secilc)

I order my modules in alphabetical order so for example
policy/modules/systemd/systemd.cil comes after
policy/modules/system/dbus for example.

If i, in the dbus.cil file now want to insert some declarations in a
systemd block i hit issues due to that ordering issue

If i move the systemd.cil up the stack then i can work around the
ordering issue but it is a dead-end. Ordering issues suck (/me points to
sidorder statement)
