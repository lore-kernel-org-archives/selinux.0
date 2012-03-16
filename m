Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GCop7e010723
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 08:50:51 -0400
Received: by bkwj4 with SMTP id j4so3283483bkw.12
        for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 05:50:49 -0700 (PDT)
Date: Fri, 16 Mar 2012 16:50:40 +0400
From: Mikhail Efremov <mikhefr@gmail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: newrole: Fix drop_capabilities().
Message-ID: <20120316165040.1509ef42@c203.office.altlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/FhoY9uYJ6kxJa.BRiFFz5Yw"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--MP_/FhoY9uYJ6kxJa.BRiFFz5Yw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

The CAP_* constants should not be or'ed, it is the bit numbers.
And grant the access to the audit system too.

P.S. May be someone can look at the commit messages, I'm not sure
about my English.

-- 
WBR, Mikhail Efremov

--MP_/FhoY9uYJ6kxJa.BRiFFz5Yw
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-policycoreutils-newrole-Fix-drop_capabilities.patch


--MP_/FhoY9uYJ6kxJa.BRiFFz5Yw--
