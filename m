Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14281
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:46:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JHkSI29863
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:46:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h1JHkRf29859 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:46:27 GMT
Date: Wed, 19 Feb 2003 12:39:25 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Apache policy
In-Reply-To: <200302191439.49511.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0302191214530.8893-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Feb 2003, Russell Coker wrote:

>
> >   - Does $1_t need create permissions for script_exec_t? (around line 88)
>
> No.  I can't find that in the version I sent you or the one in my current tree
> either.
>

  I meant, do we need to add this rule so users can relabel files as
httpd_user_script_exec_t? We also need a rule for sysadm_r to create
httpd_sys_script_exec_t, right?

>
> I've just removed httpadm.te entirely from my tree.  My changes remove the
> need for it entirely.
>

  OK, but doing that requires a change to our rbac file, and yours and our
openca-ca.te, I think. You want to remove httpd_admin_r and httpd_admin_t
entirely, right?

  Thanks,
-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
