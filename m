Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h947RqsJ014846
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 03:27:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h947Q3Zt013275
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 07:26:03 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h947Q1M3013272
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 07:26:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Question about policy files and users
Date: Sat, 4 Oct 2003 17:27:35 +1000
References: <20031003210014.7c76f52f.michaelr@cisco.com>
In-Reply-To: <20031003210014.7c76f52f.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310041727.35684.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Oct 2003 14:00, Michael Reilly wrote:
> /home/jadmin/(/.*)?                     system_u:object_r:staff_home_t
>
> (I, of course, replaced jadmin with my login name).  My question is why is
> the entry not -
>
> /home/jadmin/(/.*)?                     jadmin_u:object_r:staff_home_t
>
> When I created new files in my login directory while the selinux kernel is
> running they are labeled jadmin_u:object_r:staff_home_t

You are correct that it might be a better default to have the account identity 
specified in the file contexts so that after you login for the first time you 
have the ability to use "chcon" to change the context (try changing the 
context of a file from system_u:object_r:staff_home_t and you'll discover 
that it's denied by the constraints file).

However the problem is labeling /home.  I am considering a special entry for 
setfiles to allow specifying the identity.  Until I get that done there's no 
way of properly labeling /home, and while /home does not have identities 
assigned there seems little point in assigning them to jadmin.

> Being new to selinux I think I am missing something - why does the home
> directory and the files in that directory not set to the id of the owner
> (jadmin_u) instead of system_u?  And is my system doing something wrong by
> labeling newly created files in my login directory
> jadmin_u:object_r:staff_home_t?

No.  The labeling of the files with your identity is desired.  That gives you 
slightly greater access to them than you would otherwise have.  When you 
create a file (or it is created on your behalf by some system process) you 
have the possibility of relabeling it to a different type.  When someone else 
in the same role creates a file then you will not be permitted to relabel it.

> BTW - I installed gentoo selinux on a different machine.  Their
> installation guide indicates that the later
> (jadmin_u:object_r:staff_home_t) is correct and the policy files should be
> edited to use the jadmin_u).

Yes, perhaps we should change the default policy.  But until I do some more 
coding on setfiles the big problem will remain unsolved.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
