Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17656
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 14:53:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA25013
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:51:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA25009 for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:51:29 GMT
Date: Mon, 22 Jul 2002 14:52:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [patch] Re: chattr
In-Reply-To: <20020722180656.79B011549@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207221444060.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 22 Jul 2002, Russell Coker wrote:

> Also giving initrc access to that directory/file is a bad idea anyway, the
> sendmail start script in question should be run in the sendmail_t domain IMHO
> (as I have done for devfsd in Debian).

I'd disagree.  As a general principle, you want to limit a domain to
executing as small a set of types as possible, preferably just to its own
executable and the necessary shared libraries.

>  # Rules for /proc/sys/kernel/tainted
> -allow insmod_t sysctl_kernel_t:file rw_file_perms;
> -allow insmod_t sysctl_t:file write;
> +allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
>
> Is this really what you desire, removing the sysctl_t access?  I'm sure it
> was added for a reason...

Yes.  I think it was originally added as a workaround for out-of-date
sysctl SID tables in the SELinux module.  It should no longer be needed
for updating tainted.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
