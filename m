Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s65CdTV4028858
 for <selinux@tycho.nsa.gov>; Sat, 5 Jul 2014 08:39:29 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so777575wgh.25
 for <selinux@tycho.nsa.gov>; Sat, 05 Jul 2014 05:39:30 -0700 (PDT)
Received: from [192.168.1.101] ([84.245.1.4])
 by mx.google.com with ESMTPSA id dj2sm90717150wib.11.2014.07.05.05.39.28
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Sat, 05 Jul 2014 05:39:29 -0700 (PDT)
Message-ID: <1404563967.9852.42.camel@x220.localdomain>
Subject: secilc: is anyone able to confirm that type_change ...
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux@tycho.nsa.gov
Date: Sat, 05 Jul 2014 14:39:27 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

... rules are no longer honored using policy compiled with any of the
recent secilc revisions?

My login programs no longer relabel my login tts/pts, even though my
policy has, what i believe are, proper type_change rules.
