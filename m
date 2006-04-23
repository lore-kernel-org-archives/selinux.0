Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3ODO0I6023899
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 09:24:00 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3ODNxQT001157
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 13:23:59 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k3ODOMmW004398
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 09:24:22 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k3ODOMSa004397
	for selinux@tycho.nsa.gov; Mon, 24 Apr 2006 09:24:22 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin.torok@level7.ro>
To: selinux@tycho.nsa.gov
Subject: Labeling only policy and problems with booleans
Date: Sun, 23 Apr 2006 22:58:13 +0300
Cc: sds@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net, marius@cs.utt.ro
References: <200604021240.21290.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <200604172120.52193.edwin@gurde.com>
In-Reply-To: <200604172120.52193.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604232258.14004.edwin.torok@level7.ro>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am trying to write a policy that does only labeling.
I am asking for your opinion(s) before developing any further.

In particular I'm interesting in having sockets created by a process labeled 
with that process's type. This is by default I assume.

Furthermore I want to do this:
- The process's type shall be determined by the security context of the 
program
- launching the program should be possible from anywhere (by any other 
program)

I started my policy based on the reference policy.
So here it is the policy module:
----------
policy_module(test_module,1.0)
type myapp_exec_t;
gen_require(`
             type unlabeled_t;
        ')
files_type(myapp_exec_t)
domain_type(myapp_t)
unconfined_domain(myapp_t)
domain_entry_file(myapp_t, myapp_exec_t)
domain_auto_trans(unlabeled_t,myapp_exec_t,myapp_t)
domain_auto_trans(unconfined_t,myapp_exec_t,myapp_t)
domain_auto_trans(initrc_t,myapp_exec_t,myapp_t)
libs_use_ld_so(myapp_t)
libs_use_shared_libs(myapp_t)
role system_r types myapp_t;
role user_r types myapp_t;
-------------
I then label the program with myapp_exec_t.
Good, now I want to restrict his:
- There should be no way for a process to set its security context, 
- policy loading and relabeling should be restricted to a single domain. 
- If one enters enforcing mode, there should be no way back

So I remove the selinux_unconfined from unconfined_t, and I set the
secure_mode_policyload at runtime.
Here I got into a problem. Although I set the secure_mode (all 3 of them) to 
1, and verified that they are indeed set via /selinux/booleans, 
I still could load policy. I even got avc granted messages.

This shouldn't be happening. I examined the generated base.conf manually, but 
the only place where load_policy was allowed 
was 'if(!secure_mode_policyload)'. I commented those lines out, rebuilt the 
policy, and now I couldn't load a policy anymore. Ok this is what I wanted. 

But why didn't the booleans work? I tried setting their default values in 
booleans.conf to true, and still the same result, they weren'
t taken into consideration.

(btw, I also ran into a make bug: 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=358903, I hope this booleans 
problems isn't another build-tool related bug, if needed I can make the 
compiled policy module available for analysis)

I'll now describe my goals and motivation.
The goal is to have sockets labeled with a security context, so that I can use 
skfilter context matches in iptables to filter packets based on selinux 
security context.

I want to fireflier to work both with selinux enabled distros 
(fc5,gentoo-selinux), and those that aren't by default selinux enabled 
(debian,gentoo...).

So fireflier shall have 2 modes of operation (determined at runtime which to 
use).

Mode 1: for systems that don't have an selinux policy (yet) , but have selinux 
enabled in kernel.

Provide a base module built from the reference policy: base.pp, with the 
following modifications:
- unconfined_t domains aren't allowed to load policy
- policy load, and enforcing mode can only be done by semanage_exec_t
- transitions to (executing) semanage_exec_t|semanage_t can be done only from 
fireflier_t
- unconfined_t is allowed to execute fireflier_exec_t
- Make all programs unconfined by default
- Make the default label be default_t, or unconfined_t
- have as little performance hit on the system as possible (by removing 
unneeded types/rules)

I think the target policy is the best policy to start. 
When a new type is needed (to be used for iptables match), fireflier creates a 
new policy module for it:
----------
policy_module(new_module,1.0)
type myapp_exec_t;
gen_require(`
             type unlabeled_t;
        ')
files_type(myapp_exec_t)
domain_type(myapp_t)
unconfined_domain(myapp_t)
domain_entry_file(myapp_t, myapp_exec_t)
domain_auto_trans(unlabeled_t,myapp_exec_t,myapp_t)
domain_auto_trans(unconfined_t,myapp_exec_t,myapp_t)
can_exec(unconfined_t,myapp_exec_t)
can_exec(myapp_t,unconfined_exec_t)
can_exec(myapp_t,unlabeled_t)
role system_r types myapp_t;
role user_r types myapp_t;
---------

I also thought of having an attribute fireflier_generated, and then create a 
single rule to allow unconfined_t transition to fireflier_generated types, 
and fireflier_generated_types -> unconfined_t. Would this be faster?

Also since all programs will have unlabeled_t by default, there is no point to 
do an initial relabeling, so either:
 - mount -o context=unconfined_t
 - do nothing, and the programs will get by default unlabeled_t, or file_t, 
right?

Of course, the programs that rules are created for will get relabeled.
I am also thinking of letting the user customize the generated policy later.

Any security problems with the approach I used?

One of the other goals is the ability to be able to boot the system in 
enforcing mode, without any manual policy modifications. If all programs are 
unconfined_t/default_t will this be possible?

I also thought of creating an even more minimal base policy, but I am not sure 
what I should remove from there, without breaking anything (I've seen class, 
inherit, constrain, sid, portcon, fs_xattr,... I think these are critical for 
selinux policy work, aren't they?) Would a more minimal policy make selinux 
work faster?

Mode 2: The user already has a selinux policy

When the user wants to creat a rule for a packet, fireflier will ask if using 
the existinig domain of the program is ok (for example: the packet would be 
received by httpd_t: create a rule to allow httpd_t to receive packets on 
port 80?).
1) If the user wants to use existing domain: create iptables rule for it, and 
we are done. But all programs having that domain will have access to the 
network, which can  be a problem if they are in the user's home directory 
(user_home_t) for example.
2) If the user want only this program to have access:
- create a new domain that is equivalent to the old domain, except:
 - it is called myapp_t (of course myapp will be unique to each program)
 - it creates sockets labeled myapp_t
 - only types having the attribute myapp_sock_access will have access to the 
socket (of course myapp_t will have that attribute)
 The rest of the files created by myapp_t have the same label (or equivalent) 
as the files created if it would have the old domain
 - it has all the rights the old domain had (as long as they don't conflict 
with the ones above)

There might be one problem with "giving access only to myapp_t to its 
sockets", this might break some programs (postfix, xinetd, etc.).

Since all the programs that need access to the socket are running already (we 
are generating policies on-the-fly), we can ask the user which programs he 
wants to give access to the socket, and create a policy for that. Maybe 
creating an attribute, and applying that attribute to those programs' types, 
and create a "neverallow ~myattribute" rule for the socket access.

(Since we want  to make rules for individual programs, new types will be 
created for each program needing access to the socket, see above, and those 
new types will get the myattribute attribute; note- myattribute will be 
unique to each "rule": myattribute1, myattribute2,... or something like that)



The big issue here is creating a domain that is equivalent, because AFAIK 
there is no inheritance for types in selinux (there is inheritance for 
classes though right?).
So one possible way of doing this would be using the tool sesearch to search 
for all the transitions/allow/dontallow rules, and then do a replace of old 
type with new type, watching out for this: not giving access to the socket to 
other programs.
Is there any other way of creating an equivalent type? (I want to create an 
equivalent type, because I dont' want to change the user's policy much, I 
only want the sockets to have a different label, for the purpose of iptables 
match; as far as the selinux rules are concerned they should be identical to 
the old type).


Of course in both mode 1, and mode 2 the program will be relabeled by 
fireflier to the new type.

Are there any fundamental problems with automated policy generation like this, 
is there anything I should watch out for?

In both modes it is important to not allow arbitrary policy reload, and 
relabeling, and setcontexts. Anything else I should watch our for? 
I only want the programs I label to have their sockets labeled with that 
context.


Finally, solving the shared socket issue:

  - it will allow access to the socket for only the programs allowed by its 
policy, if a new program wants access, the user is asked, and granted his 
permission, we create an allow rule (for that socket to be accessed by that 
other program)



 

 On Monday 17 April 2006 19:06, Stephen Smalley wrote:
 > On Fri, 2006-04-14 at 23:01 +0300, Török Edwin wrote:
 > > Would there be a reason to implement floating labels in SELinux?
 >
 > Unclear.  CMWs and the Posix.1e draft had floating information labels,
 > but they were separate from the access control label.  So if implemented
 > in SELinux, they would be a separate field of the incore security
 > structures and, if required to persist, they would be a separate xattr
 > name/value pair.  They wouldn't be used for access control checking by
 > SELinux internally.  One would have to define the meaning of floating
 > for TE (or your scheme), as they aren't hierarchical.
 > Traditional
 > hierarchical floating labels track reads and writes, e.g. process
 > information label floats up upon reads to dominate the information label
 > of the object, and the object information label floats up upon writes to
 > dominate the information label of the writing process, so that if P
 > copies from object A to object B, object B ends up with an information
 > label at least as high as object A.  Whether or not this is useful has
 > been a subject of debate.
I think floating labels aren't what I want after all. Tracking when floating 
happens is complicated (for me at least), and would make writing a correct 
policy harder.
( Can't something similar be done already with MCS/MLS? Anyway MLS/MCS is  not 
what fireflier wants to do.)


P.S.: Please point out any security holes my approach might introduce, and if 
there are better ways to achieve what I want.

Cheers,
Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
