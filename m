Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA26599
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 13:23:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA26126
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 18:23:37 GMT
Received: from csoc-mail-msfc.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with ESMTP id SAA26122
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 18:23:36 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015240A4@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: compute sid
Date: Wed, 21 Feb 2001 12:23:22 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Thanks for the help,

It look like I have made the exec*_secure calls
in the wrong place in the code. I will go back through
the gdm code and look for the other places I need to 
make the changes.

Thanks.

Mark


-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Wednesday, February 21, 2001 10:55 AM
To: Westerman, Mark
Cc: 'selinux@tycho.nsa.gov'
Subject: Re: compute sid



>                   kernel: security_compute_sid:
>                  invalid context system_u:system_r:user_t for
>                  scontext=system_u:system_r:gdm_t
>                  tcontext=system_u:object_r:shell_exec_t tclass=process

This message means that there is an automatic domain
transition from gdm_t to user_t upon executing shell_exec_t,
but user_t is not a legitimate domain for the system_r role.
The policy/rbac file does not allow the system_r role to
enter the user_t domain.  In order for gdm to transition
to user_t, it must also transition to an appropriate
user identity and to the user_r role.  That requires
an explicit transition via one of the exec*_secure calls
rather than just using a default transition.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
