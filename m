Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14238
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 09:28:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA24362
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:27:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA24358
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:27:39 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mark =?iso-8859-1?q?M=FCller?= <trusted@web.de>, selinux@tycho.nsa.gov
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
Date: Wed, 28 Aug 2002 15:28:37 +0200
References: <200208281253.g7SCrQX31618@mailgate5.cinetic.de>
In-Reply-To: <200208281253.g7SCrQX31618@mailgate5.cinetic.de>
MIME-Version: 1.0
Message-Id: <20020828132838.134948FDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 14:53, Mark Müller wrote:
> I can't login directly as httpd_admin_r. The default_context is set
> properly, but the following error occurs:
>
> Local login:
>
> avc:  denied  { transition } for  pid=2178 exe=/bin/login path=/bin/bash
> dev=08:07 ino=46120 scontext=system_u:system_r:local_login_t
> tcontext=webadmin:httpd_admin_r:httpd_admin_t tclass=process
>
> I cannot solve this neither with:
> allow sshd_t httpd_admin_t:process { transition };
>
> nor with
> domain_trans(sshd_t, shell_exec_t, httpd_admin_t)
>
> (Login as user_t and newrole -r httpd_admin_r works)

Do you have the following in your rbac file?
allow system_r httpd_admin_r;

I think that the SE Linux log messages should be more verbose in such 
situations, they should mention when it's a constraint or role issue rather 
than the usual domain/type issues.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
