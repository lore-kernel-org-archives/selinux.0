Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FHXGI4027580
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 13:33:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3FHTTOv004564
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 17:29:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3FHTTY1004561
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 17:29:29 GMT
Subject: Re: SELinux version of sudo
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3E9C17E9.2060203@redhat.com>
References: <3E9C17E9.2060203@redhat.com>
Content-Type: text/plain
Message-Id: <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Apr 2003 13:33:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-15 at 10:32, Daniel J Walsh wrote:
> I have been playing around with SELinux a little and was getting 
> agravated in always changing roles and
> then having to su to root.  What I really needed was the functionality 
> of sudo and newrole combined together.

The idea of merging su and newrole has been suggested on the list
previously; please be sure that you have read the earlier discussions
and are aware of the potential risks, e.g. see the thread starting at
http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2, so that
you can avoid common pitfalls.

> Apr 15 09:13:40 pxe kernel: avc:  denied  { setattr } for  pid=2377 
> exe=/usr/bin/sudo path=/var/run/sudo/dwalsh/1 dev=03:02 ino=962189 
> scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:object_r:var_run_t 
> tclass=file

You need to define a type for the /var/run files created by sudo (e.g.
type var_run_sudo_t, sysadmfile, file_type;) and grant permissions to it
via allow rules.  It isn't clear that you should be using the existing
$1_su_t domain for this purpose, unless you are also patching su to
provide this functionality and to ensure that it does not allow
processes with uid 0 to transition to arbitrary SELinux security
contexts.  I'm also not sure whether it will end up being beneficial to
keep this as a derived domain ($1_sudo_t) from the user domain or if you
should just make it a basic domain (sudo_t in a domains/program/sudo.te
file) like newrole.  You will naturally need to use many of the same
attributes and rules as newrole_t for your desired functionality, so
extending newrole_t may be the better choice (or at least duplicating
newrole_t's rules for a new domain).

> Apr 15 09:13:50 pxe kernel:
> Apr 15 09:13:50 pxe kernel: avc:  denied  { transition } for  pid=2378 
> exe=/usr/bin/sudo path=/usr/local/selinux/bin/id dev=03:02 ino=2316548 
> scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:sysadm_r:sysadm_t 
> tclass=process

The domain must have the privrole attribute to transition to a different
role, and $1_su_t does not possess this attribute at present (whereas
newrole_t does).  You also need a domain_trans rule to authorize this
domain transition.  As above, I don't think that you should add these
attributes and rules to $1_su_t unless you are also patching the su
program, and you can copy much of what you need from the newrole_t
domain.  Starting with the newrole_t domain may be a better choice.

> Also modified policy/domains/program/newrole.te
> 
> --- newrole.te~    2003-03-06 18:13:25.000000000 -0500
> +++ newrole.te    2003-04-14 16:26:10.000000000 -0400
> @@ -27,7 +27,8 @@
>  can_exec(newrole_t, chkpwd_exec_t)
>  
>  # Allow newrole_t to transition to user domains.
> -domain_trans(newrole_t, shell_exec_t, userdomain)
> +# domain_trans(newrole_t, shell_exec_t, userdomain)
> +domain_trans(newrole_t,{ bin_t sbin_t exec_type }, userdomain)
>  domain_trans(newrole_t, ls_exec_t, userdomain)
> 
>  # Use capabilities.

This is only useful if you are modifying newrole or putting sudo into
the newrole_t domain.  It serves no purpose if you are using $1_su_t or
a completely new domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
