Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MGGngA007041
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:16:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MGBFKk013533
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:11:15 GMT
Message-Id: <200507221611.j6MGBcvx018097@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 12:11:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050722154606.21958.qmail@web34309.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I know that this is just a motivating example, but I feel compelled
>> to point out that 1) this problem is not really related to MLS in the
>> real world and
> 
> On the contrary, it is a commonly requested scenario, not always with
> web services but often enough. Frequently the situation is an
> application written and owned by a 3rd party that provides a
> "special" service of some kind. Running two servers, one at Secret,
> one at TopSecret is the mode they prefer.   

I think Karl's point, which I believe Chad also made, is that for most "MLS"
applications with 2 interfaces (e.g., guards), the whole interfaces are
treated differently (e.g., a low interface and a high interface), and
port/host level access is not the central MLS issue. Certainly true given
the lack of trusted network protocols. Of course outside of the "MLS" arena
(and also inside MLS applications as an added, but less critical "defense in
dept" security filtering), port/host level access control is used all the
time, which I think was Dan's point.

BTW, I think our only difference with Chad for the "MLS" apps is that in our
experience with many such applications using SELinux so far, we didn't need
the Bell-LaPadula MLS features; TE has proven a superior MAC mechanisms for
the needed domain separation for most guarding applications. Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
