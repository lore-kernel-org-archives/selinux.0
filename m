Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SCkbgA002778
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 08:46:37 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SCjJxl024560
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 12:45:19 GMT
Message-Id: <200506281244.j5SCiqqc027274@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: <russell@coker.com.au>, "'Casey Schaufler'" <casey@schaufler-ca.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Tue, 28 Jun 2005 08:44:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <200506280832.46267.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> In the 15 years I've been dealing with MLS systems I have never seen
>> anyone encounter the problems of category permutations. A given user
>> will be in a single category, and usually a single level. In truth, a
>> site will usually use levels or catagories, but almost never both.
>> Further, a given site will usually use system-high, system-low, and
>> two or three others.
> 
> That will make things easier for us.

The problem is building a general mechanism that can handle nearly any
situation. I agree that over the past 20+ years, most MLS applications I've
seen use a small portion of the possible lattice supported. However they use
differing portions. And some applications, in particular compartmented mode
applications, can use many categories with the potential for a large number
of points in the lattice being assigned to specific users. Worse users can
be granted and removed access to lattice points (i.e., categories) now and
then. 

Nonetheless I agree with Steve's earlier suggestions that we just have to
figure a way to build a number of "roles mapping users", potentially on the
fly, to account for any set of levels that a site may want to assign to a
user. MLS will be a small % of the SELinux systems used, and a small % of
those will use more than a few security levels. Most of the traditional uses
of MLS systems are better addressed by type enforcement, as our application
experience shows us every day. So a little pain for MLS SELinux boxes is not
unjustified for increased benefit of our suggested new user management
approach IMHO. Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
