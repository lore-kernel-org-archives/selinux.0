Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12465
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 16:39:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA12744
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 21:38:01 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id VAA12740 for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 21:38:00 GMT
Date: Mon, 18 Mar 2002 16:38:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
In-Reply-To: <20020315231922.EE0931ECB7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203181630380.1117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 16 Mar 2002, Russell Coker wrote:

> OK.  What if I make it the proceedure to use run_init to run dpkg or dselect
> for package installation or replacement?
>
> The idea of dropping the authentication out of run_init or doing any major
> change to decrease the security of my setup is not something that I am
> prepared to consider.
>
> My problem is that in the usual Debian package installation process the
> program dselect will run dpkg multiple times, each invocation may install
> multiple packages.  Each package installation may run multiple scripts that
> may end up starting daemons, in many cases the daemon start scripts will be
> run with standard input directed to be from /dev/null.  So if there is to be
> any authentication in the package installation process then it has to be
> before dselect is started.
>
> Am I on the right track now?

The problem with this approach is that initrc_t isn't authorized to
install or replace packages on the system.  Hence, you only want to
transition to system_u:system_r:initrc_t for executing the init scripts,
not the installation.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
