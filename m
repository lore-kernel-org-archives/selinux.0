Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MCpsgA004877
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 08:51:54 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MCkLKk017942
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:46:21 GMT
Message-Id: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>, <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 08:46:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <42E0E706.5050903@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Friday, July 22, 2005 8:31 AM
> To: gyurdiev@redhat.com
> Cc: Joshua Brindle; Karl MacMillan; selinux@tycho.nsa.gov
> Subject: Re: Iptables discussion
> 
> Network Integration with SELinux, stinks from a users point of view.
> 
> Lets look at some potential usage scenarios.
> 
> User has two network devices (Internal and External)  He wants to allow
> only Apache to listen on the external device, and only communicate via
> LDAP over the internal device?  How would he set that up?  (IF someone
> says he will rewrite policy, I will scream, and then ask you to write
> policy to allow this. )
> 
> MLS System, wants to have two Apache systems,  One listening at port 80
> for Top Secret communications, another at port 81 for secret.  How do
> you do this?
> 

I know that this is just a motivating example, but I feel compelled to point out
that 1) this problem is not really related to MLS in the real world and 2)
separation based on ports is _very_ unlikely to meet the requirements of a
system that will be processing data at different sensitivities.

> You want to setup a Zone Transfer between your two named servers.  You
> want to guarantee that named_t on one machine is talking to named_t on
> another machine over an encrypted line?
> 
> I believe the only way for users to do these things successfully is to
> have integration of SELinux with iptables, and no writing/rewriting of
> policy will solve the problem.
> 

I disagree - I think you are conflating two separate issues:

1) Implementation details about how SELinux enforces access control over network
resources and
2) User-interface issues about how the user specifies their security policy.

I suggest that iptables may be a part of how SELinux enforces access control,
but that in no way means that detail should be exposed to the user. In fact, as
I said in my other email on the subject, I think it is undesirable to have the
policy expressed in two divergent languages and the iptables syntax may have
some very serious problems.

Solving the user-interface issues can be done more effectively, in my opinion,
by hiding both iptables and SElinux. My preference would be to extend the
SELinux policy language to be able to express the kind of controls that you are
interested in expressing and create a configuration tool (gui or text based)
that generates the policy. That would leave a policy.conf or equivalent that
could be analyzed for correctness.

Karl 

> Dan
> 
> --

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
