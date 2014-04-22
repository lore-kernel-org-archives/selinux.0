Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MHu61t020692
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 13:56:06 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so4929650eek.13
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 10:56:04 -0700 (PDT)
Received: from [192.168.1.100] ([84.245.1.4])
 by mx.google.com with ESMTPSA id m8sm114990420eeg.11.2014.04.22.10.56.03
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Tue, 22 Apr 2014 10:56:04 -0700 (PDT)
Message-ID: <1398189362.16991.6.camel@x220.localdomain>
Subject: [secilc] typeattributeset with "and" expression does not work
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Tue, 22 Apr 2014 19:56:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

(type foo)
(typeattribute bar)
(typeattribute baz)
(typeattributeset bar (and baz foo))

It compiles but neither bar, nor baz gets associated with type foo

Also, i still have that weird boolean issue where, even though sesearch
shows the rules are loaded and enabled, SELinux still blocks the access
