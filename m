Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18300
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 15:33:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA15965
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 19:32:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA15961
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 19:32:41 GMT
Date: Wed, 28 Aug 2002 15:32:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-1?Q?Mark=20M=FCller?= <trusted@web.de>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
In-Reply-To: <200208281253.g7SCrQX31618@mailgate5.cinetic.de>
Message-ID: <Pine.GSO.4.33.0208281518590.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, [iso-8859-1] Mark Müller wrote:

> I can't login directly as httpd_admin_r. The default_context is set properly, but the following error occurs:
>
> Local login:
>
> avc:  denied  { transition } for  pid=2178 exe=/bin/login path=/bin/bash dev=08:07 ino=46120 scontext=system_u:system_r:local_login_t tcontext=webadmin:httpd_admin_r:httpd_admin_t tclass=process
>
> SSH login:
> avc:  denied  { transition } for  pid=2183 exe=/usr/sbin/sshd path=/bin/bash dev=08:07 ino=46120 scontext=system_u:system_r:sshd_t tcontext=webadmin:httpd_admin_r:httpd_admin_t tclass=process
>
> I cannot solve this neither with:
> allow sshd_t httpd_admin_t:process { transition };
>
> nor with
> domain_trans(sshd_t, shell_exec_t, httpd_admin_t)
>
> (Login as user_t and newrole -r httpd_admin_r works)

I think that the httpd_admin_r role and httpd_admin_t domain need some
work to be truly useable.  In addition to allowing the role transition
in policy/rbac and the domain transitions in {ssh.te,login.te}, you need
to work out how to deal with home directory types, terminal types, etc.
If your web administrator uses a separate account for all web
administration tasks, then you could set up a full user role via the
full_user_role() macro, with its own home directory type, terminal type,
etc.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
