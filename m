Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3N65F3Z007338
 for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2016 02:05:15 -0400
Received: by mail-pf0-f170.google.com with SMTP id n1so48055504pfn.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 23:05:13 -0700 (PDT)
Received: from localhost ([2404:e800:e600:38b:b52d:863:7600:b418])
 by smtp.gmail.com with ESMTPSA id vu5sm13462703pab.43.2016.04.22.23.05.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Apr 2016 23:05:11 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: genhomedircon USERID and USERNAME patches v2
Date: Sat, 23 Apr 2016 14:04:51 +0800
Message-Id: <1461391499-20593-1-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Version 2 of the genhomedircon patches. These fix a few issues
that Nicolas Iooss found.

Changes from v1:

- Changed the fallback for the username to "[^/]+" instead of
    "[^/]*" or ".*"
- Made args const in write_replacements()
- Combined the %{USERNAME} and %{USERID} replacements into one
    method so they both get called together. This means that
    fcontexts like "%{USERNAME}-%{USERID}" become eg "root-0"
    as expected.
- I left the gid param in the struct for now. genhomedircon
    does not generate things for eg "%wheel" which I will look
    into later.

-- Jason
