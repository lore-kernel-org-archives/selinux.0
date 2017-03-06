Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v26HJSFd008828
 for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2017 12:19:31 -0500
Received: by mail-ua0-f181.google.com with SMTP id 72so177876441uaf.3
 for <selinux@tycho.nsa.gov>; Mon, 06 Mar 2017 09:19:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1703061115270.31922@namei.org>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Mar 2017 12:19:25 -0500
Message-ID: <CAHC9VhSHU8Pw21y5Z6CPH-jgMNQ=2VXxfggUNsUrAyBkn26JxQ@mail.gmail.com>
Subject: Fwd: Kernel repository updated to v4.11-rc1
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

FYI: I've rebased the selinux/next tree.

---------- Forwarded message ----------
From: James Morris <jmorris@namei.org>
Date: Sun, Mar 5, 2017 at 7:18 PM
Subject: Kernel repository updated to v4.11-rc1
To: linux-security-module@vger.kernel.org


FYI, I've merged security-next with v4.11-rc1 and then merged the
following queued patches:

ca97d939db114c8d1619e10a3b82af8615372dae security: mark LSM hooks as
__ro_after_init
dd0859dccbe291cf8179a96390f5c0e45cb9af1d security: introduce
CONFIG_SECURITY_WRITABLE_HOOKS
84e6885e9e6a818d1ca1eabb9b720b357ab07a8b selinux: fix kernel BUG on
prlimit(..., NULL, NULL)
791ec491c372f49cea3ea7a7143454a9023ac9d4 prlimit,security,selinux: add
a security hook for prlimit

Please test!


--
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe
linux-security-module" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
paul moore
www.paul-moore.com
