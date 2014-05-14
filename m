Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4EG4sHf020475
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 12:04:54 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so1502938pbc.28
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 09:04:52 -0700 (PDT)
Received: from [10.1.1.233] (ppp167-251-123.static.internode.on.net.
 [59.167.251.123])
 by mx.google.com with ESMTPSA id gc3sm4220470pbd.93.2014.05.14.09.04.50
 for <selinux@tycho.nsa.gov>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Wed, 14 May 2014 09:04:51 -0700 (PDT)
Message-ID: <1400083486.3010.21.camel@vaio-emefes-com>
Subject: Single init script for multiple daemons
From: Mladen Sekara <dev@emefes.com>
To: selinux@tycho.nsa.gov
Date: Thu, 15 May 2014 02:04:47 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

What would be the best approach to attack this:

One application, multiple components/daemons.
Some files are specific to a daemon, some are shared between them (eg.
log files are unique, some config files, keystores... are shared etc.)

All daemons start from a single init script and I am not allowed to
change it.

Options:

1. Create policy for each component and then domain transition between
them (what about shared files???)
2. Create a single policy for multiple daemons?

Any advice...

-- 
Mladen Sekara <dev@emefes.com>
