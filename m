Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MEENI4021516
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 10:14:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MEEMtV014997
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 14:14:22 GMT
Received: from venere.mat.uniroma1.it ([151.100.50.3])
        by jazzband.ncsc.mil  with ESMTP id h4MEEHal014970 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 14:14:20 GMT
Received: from yahoo.it (archimede.mat.uniroma1.it [151.100.50.200])
	by venere.mat.uniroma1.it (8.9.1b+Sun/8.9.1) with ESMTP id QAA19302
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 16:10:21 +0200 (MET DST)
Message-ID: <3ECCDA52.5010802@yahoo.it>
Date: Thu, 22 May 2003 16:10:26 +0200
From: Giorgio Zanin <selinux_list@yahoo.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: about security contexts for objects
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I received good answer every time I posted to this mailing list, so I 
try this time too.

I am trying to get a formal model of the SELinux configuration language, 
in order to infer some properties of the system from a given configuration.
The first property I am interested in is about the access of a given 
(security context for a) subject to a given (security context for an) 
object.
A security context has three components: a "user", a "role" and a 
"type". Not all of the combinations of values for these components are 
generally allowed in the system; it depends on configuration rules. I 
call "valid" asecurity context that is allowed to be attached to a 
process or to a generic object. My problem is  how to determine valid 
security contexts.

First of all I noticed (or at least I thought) it is possible to define 
the set of all valid security contexts for subjects (process) in the 
following way:

- U is the set of all the "user" components for a security context. I 
can building up U, just examining all of the rules  as
user u roles {r1 r2 ...};

- R(u) is the set of all of the authorized roles for a given "user" u. 
It is possible to build up the set with the same rules as above

T is the set of all types, defined by rules as
type t;

T(r) is the set of domains a given role r can enter. It is possible to 
build up the set examining all of the rules as
role r types {t1 t2 ...};

So, now, the set of all possible security contexts for a subject can be 
modeled by

S = { (u,r,t) belonging to UxR(u)xT(r) }.

I can know all the valid security contexts for a process (elements of S) 
just looking at three kinds of configuration rules.

What I need now is something similar for object security contexts. The 
"role" component of such a security context is trivially "object_r". 
What about "user" and "type" components?

I thought it would be useful to define a set of valid security contexts 
with respect to a given object class.
For example, O(file) could be the set of all the valid security contexts 
for files, O(socket) the set of all the valid security contexts for 
sockets and so on, for each of the 29 object classes defined. Obviously, 
O(process) would be S.

Is it possible to define O(c) (c=a given object class different from 
"process") just looking at some configuration rules?
If I look at the file context configuration, I can get some elements of 
O(file) and O(dir), but I think I can't catch all of them.

type_transition rules could be useful  to catch some (but just some) 
elements of O(c), for a given generic class c.

So the best choice seems to be looking at access vector rules; with a 
rule as

allow A B : C P

I can argue B is a good "type" component for an object of class C. Can I 
catch all the valid "type" components in this way?

About "user" components for an object, maybe anyone is ok.

Anyone can help me in doing this?


Thank you in advance, and sorry for my bad English. I hope I have been 
at least a little clear :P

Giorgio


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
