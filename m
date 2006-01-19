Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JMkxXf008742
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 17:46:59 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JMjkgR015944
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 22:45:48 GMT
Subject: Re: next try at refpolicy-gentoo patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060119203317.GA27395@sergelap.austin.ibm.com>
References: <20060119203317.GA27395@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 17:48:37 -0500
Message-Id: <1137710918.29815.384.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-19 at 14:33 -0600, Serge E. Hallyn wrote:
> The following set of patches lets me log in locally on a
> gentoo system in enforcing mode.

Merged, with one note,

> Third, I need to send sighld from user_t to local_login_t on login,
> else I get an endless series of error messages on console
> (login: waitpid (6328, NULL, 0) failed: No child processes)
> Is this really gentoo-specific?

With some digging, and discussion in the IRC channel, this one wasn't
Gentoo specific, and due to some missing IPC rules in the domain
transition to all user domains that local_login_t was using.  I fixed
that, so this hunk isn't needed:

> Index: refpolicy/policy/modules/system/userdomain.if
> ===================================================================
> --- refpolicy.orig/policy/modules/system/userdomain.if
> +++ refpolicy/policy/modules/system/userdomain.if
> @@ -33,6 +33,10 @@ template(`base_user_template',`
>  	role $1_r types $1_t;
>  	allow system_r $1_r;
>  
> +	ifdef(`distro_gentoo',`
> +		allow $1_t local_login_t:process { sigchld };
> +	')
> +
>  	# user pseudoterminal
>  	type $1_devpts_t;
>  	term_user_pty($1_t,$1_devpts_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
