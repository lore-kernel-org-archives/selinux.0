Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0ECmfBX005689
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 07:48:41 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 5F2281A15C
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 13:48:33 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id uG8erxESHrco for <selinux@tycho.nsa.gov>;
 Sat, 14 Jan 2017 13:48:30 +0100 (CET)
Received: from [IPv6:2a02:a03f:f4:9c00:8454:e54d:8b4a:3f85] (unknown
 [IPv6:2a02:a03f:f4:9c00:8454:e54d:8b4a:3f85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 8EA901A15B
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 13:48:30 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
Subject: Wrong alignment when listing user/login with semanage in French
To: selinux <selinux@tycho.nsa.gov>
Message-ID: <2b54cfbd-56fb-a074-eeb7-11ebe02b9ecd@debian.org>
Date: Sat, 14 Jan 2017 13:48:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Not sure I already posted this on the ML.

When listing the user/login with semanage (login/user -l) in French (and 
probably in other languages as well), the columns headers are not 
properly aligned.

This makes it sometimes difficult to read the output(and it's ugly), 
see: https://i.imgur.com/zhZkebc.png

Some of the translations should maybe be fixed in this case to make them 
shorter, but the alignment should probably be dynamic.

RHEL/Fedora[1] contains the python binding for libsmartcols, maybe this 
could be used to do the formating?

Regards,

Laurent Bigonvlle

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1369558
