Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19913
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 11:04:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA22286
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 16:02:11 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA22282
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 16:02:10 GMT
Date: Tue, 29 Oct 2002 11:03:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: New Apache policy
In-Reply-To: <20021025164228.A18830@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210291020050.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 25 Oct 2002, Tom wrote:

> The second diff is a new subversion policy, using a macro as you
> suggested. It was a lot of work to get it right initially, but I do
> agree that it's the better way to do it.

A couple of questions about your Subversion policy, at least partly due to
my ignorance of Subversion:

1) Is there any way to run the server in a separate domain from httpd_t?
Would this be possible via a domain transition on the module, or is the
module not truly executed?  Alternatively, you might want to explicitly
run the httpd that you use for SubVersion in a separate domain from any
other instances of httpd so that there is no risk of the other daemons
tampering with your repository.

2) How worthwhile is it to retain a separate domain for the client?  At
present, the only important difference between the client domain and the
ordinary user domain would appear to be the permissions to the repository.
Does this correspond with the Linux protections (e.g. is the client
program a setuid or setgid program for a user or group that has
permissions to the repository, and ordinary users do not have any direct
access to the repository)?  Why does the client need direct permissions to
the repository at all if the server is used?  Is this for the local
repository case?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
