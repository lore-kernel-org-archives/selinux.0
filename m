Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5J5XUrT021977
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 01:33:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5J5XHVl025952
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 05:33:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Fedora Core 2 setools RPM
Date: Sat, 19 Jun 2004 15:33:22 +1000
Cc: "Joshua D. Guttman disp: current" <guttman@mitre.org>,
   "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com> <nhafz8s3f2y.fsf@malabar.mitre.org> <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406191533.22037.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 19 Jun 2004 04:43, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> A more realistic case is newrole.  user_t -> newrole_t -> sysadm_t is an
> allowed series of domain transitions, and the only thing preventing
> jdoe:user_r:user_t from using newrole to get to sysadm_t is the fact
> that jdoe is restricted to user_r and user_r is restricted to user_t by
> the kernel policy.  But from an information flow perspective, you simply
> want to prove that user_t can only reach sysadm_t through specific gate
> domains like newrole_t.

One feature I have suggested for policy analysis tools is a method of 
specifying policy analysis hints in the policy source.

This would allow specifying newrole_t as a gate domain as well as providing 
high level assertions about data flow.

If we are going to move to binary policy analysis then we would need some 
other mechanism for managing policy analysis information.  I think it would 
provide a significant benefit to allow policy authors to specify what the 
goals of their policy should be and then allow other people to analyse 
whether the policy meets it's goals in the context of a complete system.  
Maybe the next time we change the policy binary format we could add a field 
that the kernel would treat as a comment which could be used for checkpolicy 
to store data that can later be used by policy analysis tools.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
