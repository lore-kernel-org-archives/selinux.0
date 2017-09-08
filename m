Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v88NIM16002836
 for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2017 19:18:22 -0400
Received: by mail-qk0-f176.google.com with SMTP id b82so9683564qkc.4
 for <selinux@tycho.nsa.gov>; Fri, 08 Sep 2017 16:18:10 -0700 (PDT)
Received: from ?IPv6:2601:145:8000:a3a0:ab95:daee:5eb3:9d2f?
 ([2601:145:8000:a3a0:ab95:daee:5eb3:9d2f])
 by smtp.gmail.com with ESMTPSA id t56sm2171647qte.54.2017.09.08.16.18.09
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Sep 2017 16:18:09 -0700 (PDT)
From: Chris PeBenito <pebenito@ieee.org>
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
Date: Fri, 8 Sep 2017 19:18:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Userspace Python version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I believe that all major SELinux distributions have at least Python 3.4 
support.  Python 3 changeover has gone so long that even 3.3 is about to 
go end-of-life [1].  Can we officially drop Python 2.7 support in 
userspace code?

I'd like to drop support for everything older than Python 3.4 in SETools.

[1] 
http://blog.python.org/2017/09/python-337rc1-is-now-available-prior-to.html

-- 
Chris PeBenito
