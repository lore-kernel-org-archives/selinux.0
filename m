Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA14570
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 15:20:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA09375
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 19:19:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA09371
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 19:19:16 GMT
Date: Tue, 2 Oct 2001 15:20:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "John S. Gage" <jgage@epo.som.sunysb.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Debian distribution of selinux
In-Reply-To: <5.1.0.14.0.20011002130836.00a98d00@informatics.informatics.sunysb.edu>
Message-ID: <Pine.GSO.4.33.0110021511290.14371-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2 Oct 2001, John S. Gage wrote:

> Is selinux going to be made into a Debian distribution?  That would be a
> good thing.

There seems to be some interest by some of the Debian developers in
creating a SELinux package for the Debian distribution, as evidenced by
the recent email by Manoj Srivastava and Russell Coker on the selinux
list.  See the current mailing list archives (available via email to
majordomo@tycho.nsa.gov or online at
http://marc.theaimsgroup.com/?l=selinux).

I agree that this would be a good thing, and we are trying to be helpful.
However, it will take a certain amount of work, even aside from packaging
issues, since the example policy and the modified daemons and utilities were
based on a RedHat distribution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
