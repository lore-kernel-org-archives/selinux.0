Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8S37Zpq000853
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 23:07:36 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8S36m6B027386
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 03:06:49 GMT
Message-ID: <4AC02871.9060608@ak.jp.nec.com>
Date: Mon, 28 Sep 2009 12:07:29 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH v2 2/2] selinux:  generate flask headers during kernel
 build
References: <1253833647.2452.4.camel@moss-aggies>
In-Reply-To: <1253833647.2452.4.camel@moss-aggies>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Add a simple utility (scripts/selinux/genheaders) and invoke it to
> generate the kernel-private class and permission indices in flask.h
> and av_permissions.h automatically during the kernel build from the
> security class mapping definitions in classmap.h.  Adding new kernel
> classes and permissions can then be done just by adding them to classmap.h.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> ---
>  scripts/selinux/Makefile                  |    4 +-
>  scripts/selinux/genheaders/Makefile       |    5 +
>  scripts/selinux/genheaders/genheaders.c   |  118 ++++
>  security/selinux/Makefile                 |    3 +
>  security/selinux/include/av_permissions.h |  870 -----------------------------
>  security/selinux/include/flask.h          |   91 ---
>  6 files changed, 128 insertions(+), 963 deletions(-)
>  create mode 100644 scripts/selinux/genheaders/Makefile
>  create mode 100644 scripts/selinux/genheaders/genheaders.c
>  delete mode 100644 security/selinux/include/av_permissions.h
>  delete mode 100644 security/selinux/include/flask.h

It seems to me flask.h and av_permissions.h are not generated prior to
compile source files, such as avc.c.

[kaigai@saba selinux-2.6]$ make
  CHK     include/linux/version.h
   :
  CC      security/selinux/avc.o
In file included from security/selinux/avc.c:32:
security/selinux/include/avc.h:20:19: error: flask.h: No such file or directory
security/selinux/include/avc.h:21:28: error: av_permissions.h: No such file or directory
make[2]: *** [security/selinux/avc.o] Error 1
make[1]: *** [security/selinux] Error 2
make: *** [security] Error 2

BTW, it needs to be built prior to the building mdp.c?

  HOSTCC  scripts/selinux/mdp/mdp
scripts/selinux/mdp/mdp.c:32:19: error: flask.h: No such file or directory
make[3]: *** [scripts/selinux/mdp/mdp] Error 1
make[2]: *** [scripts/selinux/mdp] Error 2
make[1]: *** [scripts/selinux] Error 2
make: *** [scripts] Error 2

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
