Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n473v4pB005762
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 23:57:06 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n473v2rC010407
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 03:57:03 GMT
Message-ID: <4A025C03.50907@ak.jp.nec.com>
Date: Thu, 07 May 2009 12:56:51 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Refpolicy <refpolicy@oss.tresys.com>
Subject: Re: [refpolicy] [RFC] mod_selinux security policy
References: <49F69A33.2070601@ak.jp.nec.com>
In-Reply-To: <49F69A33.2070601@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Folks,
> 
> Nowadays, I'm also under development for a loadable module on apache/httpd,
> named as mod_selinux.so. It enables to launch web-applications with an
> individual security context based on http-authenticated users.
> It internally uses a one-time worker thread for each connections to perform
> as a restrictive domain bounded to httpd_t due to the hard-wired rule for
> multi-threading process.
> 
> In the LCA2009 demonstration, all we can show was individual MCS category
> per http-users because of lack of TE policy.
> The following ugly policy is an example of TE policy for mod_selinux.so.
> 
>  http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.te
>  http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.if
> 
> We needed to remain a minimum set of privileges on the bounded domains because
> they also perform as a part of the daemon process, although they are restricted
> to access to the web contents or database objects.
> (Thus, it allows webapp_type to write on log files, for example.)
> 
> In my hope, if we can have a interface to assign the minimum set of privileges
> on the bounded domain, it will be helpfull for authors of web applications
> which provide its own security policy. It will enables them to focus on writing
> their policy for web contents.

One possible idea is to define a new attribute (e.g httpd_server_type) which
contains httpd_t and other domains for built-in web applications.
A minimum set of privileges to perform as a web server process is allowed
on the httpd_server_type, and rest of permissions are allowed on individual
types.

Or, add a new template/interface to allow minimum privilges to perform as
a web server process (e.g httpd_server_domain), then httpd_t and other
domains for built-in web applications uses this template/interface.

Anyway, the mod_selinux currently copies and pastes a part of policies for
apache, but it is not basically good due to the code duplication.

I would like to get any comments prior to the pushing the package to Fedora.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
