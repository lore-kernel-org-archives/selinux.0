Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03097
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 09:30:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA27874
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:29:12 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA27870 for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:29:12 GMT
Date: Thu, 8 Aug 2002 09:23:45 -0400 (EDT)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Samarth  Sharma <samarth7880@rediffmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: policy for new user?
In-Reply-To: <20020808122929.32575.qmail@webmail26.rediffmail.com>
Message-ID: <Pine.LNX.4.33.0208080908370.9323-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8 Aug 2002, Samarth  Sharma wrote:

> hi,
>
> 1>i added a new user with sysadm_r role.however this user was not
> able to run the program "adduser" .. eventhough this user has
> sysadm role.

  'adduser' still needs to run as the root user because normal permissions
are still enforced by the kernel.

> 2>how do you create a file with system_u identity?

  There are several ways to change the context on a file.

  1) Use the 'chsid' program.
  2) A rule in the policy may cause a file label to be set based on the
     context of the process and context of the parent. For example:
     file_type_auto_trans(sshd_t, var_run_t, sshd_var_run_t)
  3) Relabel using the 'setfiles' program. Running 'make relabel' in the
     policy directory will do this.
  4) A process can create files with labels by using the open_secure()
     function, or relabel files using the chsid() function, within the
     constraints of the policy.  Refer to the
     selinux/libsecure/include/fs_secure.h header file for the definitions
     of these functions, and selinux/libsecure/man/man2 for the man pages
     containing additional information on the extended system calls.

 --
Wayne Salamon
wsalamon@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
