Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74A7HrT026997
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 06:07:17 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74A6g0G004658
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 10:06:43 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Colin Walters <walters@redhat.com>
Subject: Re: [patch] fix /var/run/console bits
Date: Wed, 4 Aug 2004 20:07:03 +1000
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
References: <1091584911.8312.7.camel@nexus.verbum.private>
In-Reply-To: <1091584911.8312.7.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408042007.03512.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Aug 2004 12:01, Colin Walters <walters@redhat.com> wrote:
> Currently /var/run/console is labeled as xdm_var_run_t, which is totally
> wrong, since it's actually owned by pam_console.  I noticed this while I
> was trying to work on the D-BUS policy, which recently gained console
> user authentication.
>
> Attached is a patch which creates a new type for it, grants the
> requisite permissions to login and xdm.  I still think we need a nicer
> way of mapping the PAM permissions in policy.  The only reason that
> login and xdm are granted these permissions is because they happen to
> ship with pam_console in their PAM stack on Fedora, presumably.  (IIRC
> Debian doesn't use pam_console).

I think that perhaps the following would be good for the fc entry to keep the 
convention:
/var/run/console/(.*)?                     system_u:object_r:pam_var_console_t

This is not what we want.  Ideally we will never have any files of type 
var_run_t.
rw_dir_create_file(xdm_t, var_run_t)
rw_dir_create_file($1_login_t, var_run_t)

I guess that the following code is to allow the xdm to check which login 
processes are active when searching for an unused virtual console.  If my 
guess is correct then signull access would need to be granted to getty_t and 
userdomain.  Of course if you hard-code a VC in the config file then maybe 
this isn't needed.
# FIXME: what is this for?
ifdef(`xdm.te', `
allow xdm_t $1_login_t:process { signull };
')

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
