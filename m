Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7U6QVLa001187
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 02:26:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7U6P1pQ014030
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 06:25:01 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h7U6OxQX014027
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 06:25:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Subject: Re: Type background of SELinux
Date: Sat, 30 Aug 2003 16:26:19 +1000
Cc: <selinux@tycho.nsa.gov>
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3566@etsuex1.etsu.edu>
In-Reply-To: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3566@etsuex1.etsu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200308301626.19985.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 30 Aug 2003 07:22, Jenkins, Steven wrote:
> * is there a notion of dynamic types?  

Every type is coded into the policydb.  If you run a policy analysis tool 
against the policydb or inspect the textual source file policy.conf you can 
see the names of all types that may be used.

While a system is running you can not add new types or remove old ones unless 
you load a new policy.

Loading a new policy to a running system is something you want to do with some 
care.  If you have a need to routinely do this (IE having different policies 
for a laptop or PDA depending on whether you are in the office or on the 
road) then you want to make sure that both policies have the same types and 
that they only differ in the access that is granted.  Also if you take away 
access from a program then you want to make sure it still has access to send 
SIGCHLD to init_t etc, otherwise it may hang around until you reboot.

> * is there a common type hierarchy (or type tree, as in how C will
> automatically coerce int's into float's, for example)

No.  There is nothing in the policy that directly indicates that one type is 
in any way more important than the others.  Humans know that certain types 
are more important as they have access to more things.  Policy analysis tools 
will also support methods for dealing with this information.

You could write yourself an addition to the policy language that has a 
hierarchy of types, or a pre-processor for the policy language (think 
C-Front).  But so far no-one has done this AFAIK.

> * how are
> interpreters (such as perl, python, etc) handled that have direct access to
> the C library?

You can have two different Perl scripts run in different security contexts.  
The context is based on the script name.  This has some issues regarding 
sym-links so it's recommended that automatic domain transitions only occur to 
domains with less access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
