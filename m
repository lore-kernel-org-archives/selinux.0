Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06449
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:21:04 -0400 (EDT)
Date: Tue, 1 Oct 2002 13:20:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200210011902.36463.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011319460.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Russell Coker wrote:

> Yes we do.  I think that we need to radically change the way setfiles works
> for home directories.  But in the mean time just adding something like the
> following to xauth.fc should do:
> /home/[^/]*/.Xauthority.*     system_u:object_r:user_home_xauth_t

Ok, and I also added an entry for /root/.Xauthority with the
sysadm_home_xauth_t type.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
