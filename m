Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6UJpbkM012926
 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 15:51:37 -0400
Received: from [192.168.178.21] ([78.54.148.152]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LoE4f-1WWeWK01dZ-00gDDP for
 <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 21:51:41 +0200
Message-ID: <53D94CCC.8000307@gmx.de>
Date: Wed, 30 Jul 2014 21:51:40 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: %u in format string (no. 1) requires 'unsigned int *' but the argument
 type is 'int *'.
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

/me wonders if this issue (found by cppcheck) :

        ret = -EINVAL;
        if (sscanf(page, "%u", &new_value) != 1)<--- %u in format string (no. 1) requires 'unsigned int *' but the argument type is 'int *'.
                goto out;

is already in one's trivial patch queue ?
-- 
Toralf
