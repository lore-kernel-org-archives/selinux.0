Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07532
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 08:54:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA24060
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:53:20 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA24056 for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:53:19 GMT
Date: Mon, 11 Feb 2002 08:53:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: changing a process SID
In-Reply-To: <20020209051145.10FB23A6ACC@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202110851090.5822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 9 Feb 2002, Russell Coker wrote:

> Is it possible for a process to change it's own SID?  Or is execve_secure()
> the only way?

A process can only change SIDs upon program execution, either via an
automatic transition defined in the policy or via an explicit
execve_secure.  This permits control over the inheritance of state and the
initialization of the process in the new SID.  setuid()-style operations
considered harmful.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
