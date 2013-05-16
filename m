Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4GEAO1u026368
	for <selinux@tycho.nsa.gov>; Thu, 16 May 2013 10:10:24 -0400
Message-ID: <5194E8CD.4020906@redhat.com>
Date: Thu, 16 May 2013 10:10:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
References: <5194E01F.2040505@tresys.com>
In-Reply-To: <5194E01F.2040505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/16/2013 09:33 AM, Steve Lawrence wrote:
> It has become clear that SETools has fallen behind userspace in terms of 
> features and general maintenance. We would like to get it to the point 
> where this is not the case, and to find a way to make sure it does not 
> happen again. We think the solution to the maintenance issue is to make it
> more visible by merging the more useful parts of SETools into the userspace
> repo, while deprecating/removing the remaining pieces.
> 
I think this would be a good idea.   I have been adding sepolicy which uses
libapol and libqpol, to gather data from the installed policy.  We have
several patches for setools that never made it upstream.  We also are heavy
users of sesearch and seinfo, although would could replace these with python
tools using the seinfo and search python bindings.

Over the summer we beginning to build a new gui based on the sesearch and
seinfo python bindings.  along with a lot of the work we have done in sepolicy.

Our first goal is to reveal all of the infomation that we currently have in
the SELinux Policy Man pages in an active presentation.   The idea is to allow
an administrator to "browse" all of the policy that effects a particular
executable.  For example the admin selects httpd and sees tabs for all of the
booleans, network ports, entry point paths, file types, places apache can
write, applications that apache can transition too.  Not just the types but
also the actual values.

# sepolicy network -d httpd_t
httpd_t: tcp name_connect
	dns_port_t: 53
	http_port_t: 80,81,443,488,8008,8009,8443,9000
	ocsp_port_t: 9080
	kerberos_port_t: 88,750,4444
	pop_port_t: 106,109,110,143,220,993,995,1109
	smtp_port_t: 25,465,587
httpd_t: tcp name_bind
	ntop_port_t: 3000-3001
	http_cache_port_t: 8080,8118,8123,10001-10010
	http_port_t: 80,81,443,488,8008,8009,8443,9000
	puppet_port_t: 8140
	jboss_messaging_port_t: 5445,5455
	jboss_management_port_t: 4712,4447,7600,9123,9990,9999,18001
httpd_t: udp name_bind

# sepolicy transition -s httpd_t | head
httpd_t @ httpd_suexec_exec_t --> httpd_suexec_t
httpd_t @ mailman_cgi_exec_t --> mailman_cgi_t
httpd_t @ abrt_retrace_worker_exec_t --> abrt_retrace_worker_t
httpd_t @ dirsrvadmin_unconfined_script_exec_t --> dirsrvadmin_unconfined_script_t
httpd_t @ nagios_services_plugin_exec_t --> nagios_services_plugin_t
httpd_t @ httpd_rotatelogs_exec_t --> httpd_rotatelogs_t
httpd_t @ pwauth_exec_t --> pwauth_t
httpd_t @ abrt_helper_exec_t --> abrt_helper_t
httpd_t @ nagios_system_plugin_exec_t --> nagios_system_plugin_t
httpd_t @ sepgsql_trusted_proc_exec_t --> sepgsql_trusted_proc_t

Then the next step would be to allow users, to customize the policy by turning
on booleans or changing network ports or adding file context.

libapol and libqpol become critical to getting to this point.


In fedora and RHEL7 we are dropping support for a few of the executables that
we do not want to support.  Also apps that have more traditional ways of
discovering the data.

rpm -qla setools\* | grep bin
/usr/bin/apol
/usr/bin/seaudit
/usr/sbin/seaudit
/usr/bin/sediff
/usr/bin/seinfo
/usr/bin/sesearch

> However, we are well aware of the complexity of SETools, primarily libapol,
> and that upstreaming it without any changes would not solve the problems.
> So, we have done a little work behind the scenes to find a way to reduce
> the complexity of libapol. As a first stab at it, we started with an older
> version of libapol that is quite a bit less complex and began porting it
> forward for use with modern userspace, and seeing if it would make sense to
> eventually merge. But before we get too deep into this port, we wanted to
> start a discussion with the SELinux community to make sure we are headed in
> the right direction. So to start, does this seem like a good idea (both
> merging with userspace and porting older libapol)? Or should we take a
> completely different direction (e.g. the use of graphing databases as a
> replacement of apol has been mentioned in the past)?
> 
> Another discussion we would like to have, which may affect the future of 
> SETools/apol, is CIL. Is there still interest in CIL? And if so, have there
> been any thoughts on using and migrating to CIL? Is more work needed before
> this can happen? Has anyone put thought into higher level languages that
> could sit on top of CIL? If there is interest, this may affect the SETools
> changes, for example, syntactic policy analysis for CIL is likely very
> different than current policy.
> 
As far as CIL is concerned, we love the idea, and would love to use it, but we
need to get it as a replacement for current policy with limited work.

> Thanks, - Steve
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGU6M0ACgkQrlYvE4MpobM2xwCfXG/YGDbDuR+mOpfc3qyByGVv
+hIAoMCLJu27AhJ5NG7WsaT0c+Rk+FH2
=Unbw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
