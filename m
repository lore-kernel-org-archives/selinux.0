Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
Subject: RE: Security policy analysis
Date: Wed, 10 Oct 2001 16:11:32 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIOENNJPAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.GSO.4.33.0110101530440.16839-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> So perhaps checkpolicy needs to be revised to generate an intermediate set
> of data structures that are more suitable for policy analysis tools prior
> to generating the final set of data structures for the kernel security
> server?

I think what Steve says is all reasonable and like I mentioned before, it
wouldn't be hard to put what we have into checkpolicy even with two
different policy DBs.  Like I said, we really didn't set out to build a
tool, but to analyze policies and so what we have can be viewed as a rapid
prototype that we will likely continue to add to.

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
