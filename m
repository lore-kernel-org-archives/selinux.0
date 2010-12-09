Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB9GCBZo012476
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 11:12:12 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oB9GCAhq008097
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 16:12:10 GMT
Message-ID: <4D00FF6C.2070204@manicmethod.com>
Date: Thu, 09 Dec 2010 11:10:20 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: Recent status of SE-PostgreSQL
References: <4CFF0564.1080107@ak.jp.nec.com> <AANLkTi=j9OCJ=0iGDEoAzwennWBJMiB=Env376+NoE0g@mail.gmail.com> <4D0017A7.7030605@ak.jp.nec.com> <4D0023C4.8010207@itechfrontiers.com> <4D0094F0.1050108@ak.jp.nec.com> <4D00CB7F.80603@itechfrontiers.com>
In-Reply-To: <4D00CB7F.80603@itechfrontiers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

cto@itechfrontiers.com wrote:
> KaiGai,
>
> Thanks for explanation, I see, but it seems I need to explain my points:
> (We are talking about designing and implementing secure and robust systems) and
> I had objections based on Practical utilization,
>
> 1) From System Wide Perspective, PostgreSQL is another daemon and should not be
> trusted and thus we give it unprivileged user and control its entire daemon with
> MAC and give Postgres its own little island to rule (I'm sure you aware of this)

Postgres is inherently trusted with it's own objects, the kernel cannot mitigate 
that. The idea is to use extend access controls deeper into objects that the 
kernel cannot itself control access to. The Postgres process and database files 
will be protected by SELinux using kernel access controls and SELinux policy is 
extended into Postgres.

As an example, lets talk about MLS. If a secret user cannot access top secret 
data on the filesystem, but can in the database your system is not capable of 
implementing the security model you've deemed necessary.

There are several current and historic implementations of database systems that 
implement an MLS policy. Where they fall short is integration with the rest of 
the security policy.

Because SELinux provides ways to 1) get the context of a process on the other 
end of a socket from the kernel, 2) use that context to get access control 
decisions from the in-kernel SELinux policy and 3) implement a consistent policy 
across multiple object managers we are able to build a comprehensive and deep 
security policy that cannot be bypassed (assuming your policy does not allow 
bypass).

Using labeled networking it gets even better. Someone sitting on a desktop 
running a database client labeled someuser:nurse_r:nurse_t can have precise 
access granted to the patient tables via labeling, specific columns can be 
removed from their view. Regardless of the credentials used to log in to the 
DBMS the MAC policy takes priority.

>
> 2) You are going to put the same tool, SELinux to rule that little island of
> PostgreSQL, for internal objectives, access control and virtual users:
>
> In my Mumble Opinion, The are objections IN PRACTICAL usage here:
>
>
> 2-1) IMHO, Using the same SELinux for creating control on internal daemon
> architecture (access) is in contrary to "Defense in Depth doctrine" (there
> supposed to be different layers of security and defense, and not to rely on a
> single point of failure which here is actually policy making and administration
> of those policies)
>

Quite the contrary. How do you suppose you will protect access to objects that 
are opaque to the kernel without implementing a security model in the daemon?

> 2-2) IMHO, down from hierarchy of system wide (kernel), MAC/RBAC INTERNALLY
> within daemons (programs) should be MAC/RBAC by design not as an add-on of
> external source , A) because of performance implications B) they are not on the
> same level of trust in contrast to security, and Security adminis cannot deal
> with internal structures and objectives of applications in practical daily
> usages this is why they are isolated, it is up to the developers to provide and
> thus why an external source which is resource intensive should be used, Virtual
> user privileges within database are not mapped directly to system resources,
>
>
> 2-3) Adding SE-PostgreSQL does not bring the daemon at the same level of trust
> and it should be sandboxed or isolated anyway, and of course internal users of a
> DBMS should not be mapped from system users, this is why VIRTUAL users are used
> within DBMS , (same defense doctrine)
> so why should use an external source for MAC/RBAC, when it should be MAC by
> design not as an add-on
>
>
> 2-4) In secure deployment a MIDDLEWARE is placed between web and a totally
> isolated DBMS for the purpose of Content filtration and analysis (not to trust
> WEB applications or its programmers) and for the purpose of load balancing, as
> well as security isolation, (AT LEAST WE DO SO)
> for trusted systems, it is possible to put a single database within a single
> instance of Postgresql and do not share it with other databases,
> since postgresql is process based it does not introduces much more resource
> consumption (as it only needs one additional master process per instance of
> PostgreSQL)
>

Trusting the middleware is placing trust in the wrong layer. You must implement 
access controls in the object owner to have any assurance that it is 
non-bypassable.

If you can find it, dig up the papers written for the Integrity Lock DBMS. They 
are a bit dated (we are talking 80's). Also Security in Computing by Pfleeger 
has a chapter on database security.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
