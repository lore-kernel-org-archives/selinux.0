Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA21225
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 11:49:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA28886
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 16:49:06 GMT
Received: from ecstasy.ksu.ru (ecstasy.ksu.ru [193.232.252.41])
	by jazzband.ncsc.mil  with ESMTP id QAA28882
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 16:49:05 GMT
Message-ID: <3AB8DAEA.6050606@ksu.ru>
Date: Wed, 21 Mar 2001 19:46:34 +0300
From: Pedro Rosa <Pedro.Rosa@ksu.ru>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: Pedro Rosa <Pedro.Rosa@ksu.ru>, selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
References: <Pine.SOL.3.95.1010321082240.12705E-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> As I mentioned earlier, the LIDS FAQ itself uses the term
> "mandatory access control" to describe some of the LIDS features.
> The LIDS ACLs and capability assignments are administratively-defined,
> so a system-wide security policy can be enforced on the granting of file
> accesses and capabilities.  The protections against killing certain
> processes in LIDS are a limited form of the general process-to-process
> signal access controls in SELinux.

I didn't read the FAQ. Maybe LIDS claims or tries to support or messes 
with the MAC term.
However let's note that inside the code there are no primary references 
to a MAC architecture. Well I noted only a clear mandatory policy and 
which is giving users the chance to modify some LIDS options, including 
turining it off. But I don't see clearly a server or daemon doing the 
big job controling these "rights".

> 
> 
> I'm not sure what you mean when you say that SELinux MAC is controlled
> from a central point and that LIDS is not controlled from any center.  If
> you are referring to the security server, keep in mind that the security
> server is merely a subsystem in the kernel that reads the policy
> configuration from a local file during startup (or during subsequent
> policy reloads). The lack of an equivalent to the security server in LIDS
> is simply a reflection of the fact that LIDS does not try to provide
> flexible support for security policies.  But both systems allow different
> policies to be defined for different machines if desired.

But, as far as  could understand from the selinux docs, this subsystem 
is an independent identity with a proper set of functions and which can 
be local or expanded to a network. This "automata" is a very specialized 
unit that not only sets but also controls the permissions. On the other 
way LIDS is more a set of kernel "anchors" that permit or restrict the 
use of certain resources. 

> 
> 
> I'm also not sure what you mean by your discussion of untrusted
> vs. trusted environments.  The mandatory access controls of SELinux
> are quite useful for limiting the damage that can be caused by
> flawed or malicious applications and for supporting different
> levels of trust among users.  So SELinux should be quite useful
> in the same environments where LIDS is useful.

Well I really don't think so. You are quite correct in noting the fact 
that SELinux is useful to limit possible damages. But note that this 
kind of architecture is in fact quite vulnerable in places where 
malicious users are present or there are serious flaws in the 
communication infrastructure. Besides guarantees against malicious 
applications fall in the measure of how this environment may allow their 
presence. One of NSA docs exactly referred to this point. From what I 
could get, SELinux is only useful when you have an have a secured 
office, do a good care to check apps and users and have some good 
firewall system to protect the LANs. In this case SELinux complements 
this environment by distributing resources according to policy uses, and 
caring for their limited use, in face of a control system. Anyway 
SELinux is not strong enough to avoid systematic attacks or covert 
agents or a bugged network. Besides, it has not a serious system of 
countermeasures and accounting beyond its access policies.

On the other side LIDS is weaker on MACs and ACLs. Well, as an example 
among many, we see that LIDS does not demand any changes on user 
programs, while SELinux highly recomends/demands such changes to be 
made.  Besides it possesses less ideological congruence in its parts. In 
a office environment it is of less use than SELinux. Personally I would 
shoot the first LIDS user, if my office would be made of a SELinux 
environment. Surely I wouldn't risk the use of LIDS as it is quite hard 
to use it in a large net with many users. If I can have some control on 
the users and everything that sorrounds their workstations then I would 
opt for SELinux as it fits for the task.

However if the user has to travel somewhere and carries a notebook, then 
I would surely put LIDS on it, and NOT SELinux. Apart of being weaker, 
in a worst case scenario, the LIDS machine has the potential of giving 
some information about a break-in. However, in the same situation, a 
SELinux may pass well away and carry back a danger to the trusted 
environment. Also I would risk the use of  LIDS in such environments 
like student classes, even if there are hundreds of users and it would 
be quite hard to control the network. However it is very hard to trust 
such net. Frankly, it is impossible to be trusted if you give some 
freedom to users. So one should not only care about permissions but also 
to get a record on activities that may put these permissions in danger.

Anyway I think both systems are well in their infancy. SELinux looks 
more solid due to the detailed overwork and documented design. But the 
tight  conception makes it loose a few points to LIDS as this one is 
relatively more broad and flexible in its tasks.

Ektanoor

> 
> 
> --
> Stephen D. Smalley, NAI Labs
> sds@tislabs.com
> 
> 
> 
> 
> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
