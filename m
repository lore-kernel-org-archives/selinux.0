Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0QEQMJr015376
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 09:26:24 -0500
Received: from collab.rosalab.ru (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0QEQKLa024581
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 14:26:21 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by collab.rosalab.ru (Postfix) with ESMTP id A9CFA29C2B4
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 18:26:17 +0400 (MSK)
Received: from collab.rosalab.ru ([127.0.0.1])
	by localhost (collab.rosalab.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csup+zVEtCbv for <selinux@tycho.nsa.gov>;
	Thu, 26 Jan 2012 18:26:17 +0400 (MSK)
Received: from localhost.localdomain (unknown [192.168.20.123])
	by collab.rosalab.ru (Postfix) with ESMTPSA id 1FC0129C2B2
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 18:26:17 +0400 (MSK)
Message-ID: <4F2162D8.5080508@rosalab.ru>
Date: Thu, 26 Jan 2012 18:27:36 +0400
From: Budanov Eugene <eugene.budanov@rosalab.ru>
MIME-Version: 1.0
To: SELinux Upstream <selinux@tycho.nsa.gov>
Subject: Re: Compiler cannot find ruby.h
References: <4F2110C5.5060100@rosalab.ru> <CACLa4pu-R8SQr-_3yzAVeQ8Ebz=gzVbn7tetDC-LjE95OS1jpg@mail.gmail.com>
In-Reply-To: <CACLa4pu-R8SQr-_3yzAVeQ8Ebz=gzVbn7tetDC-LjE95OS1jpg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all!
> I believe you need to install the ruby-devel package.  (Which I
> believe is properly listed in the BuildRequires for that RPM)
[root@localhost SPECS]# rpm -qa | grep ruby
lib64ruby1.8-1.8.7.p352-3-mdv2012.0.x86_64
ruby-1.8.7.p352-3-mdv2012.0.x86_64
ruby-devel-1.8.7.p352-3-mdv2012.0.x86_64

ruby-devel is listed in BuildRequires properly.

----
Best regards,
Budanov Eugene ROSA Lab.
Russia, Moscow.
e-mail : eugene.budanov@rosalab.ru
phone +79160674716 (UTC +4)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
