Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SEh5gA003906
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 10:43:07 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SEgNaC021334
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 14:42:23 GMT
Message-ID: <36282A1733C57546BE392885C0618592A25876@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Frank Mayer <mayerf@tresys.com>, russell@coker.com.au,
   "'Casey Schaufler'" <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Alternative user management approach
Date: Tue, 28 Jun 2005 10:43:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


First, I would like to state a method for limiting the need to reload the
policy and make it work in a distributed environment is certainly needed.

> 
> The problem is building a general mechanism that can handle nearly any
> situation. I agree that over the past 20+ years, most MLS applications
I've
> seen use a small portion of the possible lattice supported. 

It is true that a small subset of labels are used in a number of
environments, there are special cases where people create and use dynamic
labels on the fly thus utilizing a large number of categories.


> However they use differing portions. And some applications, in particular 
> compartmented mode applications, can use many categories with the
potential for 
> a large number of points in the lattice being assigned to specific users. 
> Worse users can be granted and removed access to lattice points (i.e., 
> categories) now and then. 
> 

It is very true that different user's will have different clearances.
Depending on the number of levels (usually a couple) and categories (can
vary from a few to many) you could require alot of different combinations. 

Another factor in the potential increase of mappings would the increased use
of roles. Currently, their use is very limited, but if you increase the
roles to allow users to perform different actions, you increase the number
of combinations as well. 

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
