Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKT011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:22 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so89114938pfb.1
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:19 -0700 (PDT)
Received: from localhost ([2404:e800:e600:57b:dcfa:b5a4:c9d2:f744])
 by smtp.gmail.com with ESMTPSA id j2sm22082411paa.46.2016.08.04.11.34.16
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Aug 2016 11:34:17 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: Python3 support in policycoreutils
Date: Fri,  5 Aug 2016 02:33:53 +0800
Message-Id: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

This updates almost everything to be compatible with both python2 and 3.
It still uses setools3 tho and the C module. I have a work in progress for
updating sepolicy to use setools4 but those will come later.

-- Jason
