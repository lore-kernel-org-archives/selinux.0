Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04490
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 09:31:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA28418
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:29:52 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA28414 for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:29:52 GMT
Date: Wed, 24 Apr 2002 09:30:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: xserver_domain(xdm)
In-Reply-To: <20020424002120.DB7432FF42@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204240919080.17117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Apr 2002, Russell Coker wrote:

> I am now thinking that to login to an X server as sysadm_t is probably a bad
> idea anyway, so maybe I should just have xdm run the X server as
> user_xserver_t.
>
> What do you think?

So, what is the expected usage of the system by an administrator?  If you
login to [gkx]dm as user_r and then use newrole in a terminal, your X
server will still be running in user_xserver_t.

At present, if you want to maintain separation, you have to run X via
startx after a normal login, in which case it will pick up the appropriate
user_xserver_t or sysadm_xserver_t domain.

> Also is anyone looking into extra security hooks for X?  Is it at all
> possible to prevent keyboard snooping by any misbehaving X program?

We are interested in integrating security hooks and access controls into
the X server to support enforcement of policies.  This was previously
explored for DTOS, a predecessor of SELinux, in the DX server (Kirk Joseph
Bittler, A Policy-Independent Secure X Server, Master's Thesis, Portland
State University, 1997).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
