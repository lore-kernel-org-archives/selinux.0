Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBI6Cce1026128
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 01:12:39 -0500
From: Hannu Savolainen <hannu.savolainen@huawei.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: security_bounded_transition fails
Date: Fri, 18 Dec 2015 06:12:21 +0000
Message-ID: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I'm having a problem with a multithreaded application. It does lengthy  initialization in advance under relatively privileged context and then switches to a less privileged one after the moment when the actual request arrives. After that it will create a chrooted container and join all threads to a new SELinux context.

However the transition fails with audit message "op=security_bounded_transition result=denied oldcontext=old_context newcontext=new_context".

Is there any policy rule that could be used to fix this or is this just not supported?

Best regards,

Hannu
