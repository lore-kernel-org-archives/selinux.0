Message-Id: <200503071506.j27F6r8R011778@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>, "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Thomas Bleher'" <bleher@informatik.uni-muenchen.de>,
   <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Proposed policy feature: $1_domain attribute
Date: Mon, 7 Mar 2005 10:06:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1109700467.3682.24.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Ivan Gyurdiev
> Sent: Tuesday, March 01, 2005 1:08 PM
> To: Stephen Smalley
> Cc: Thomas Bleher; selinux@tycho.nsa.gov
> Subject: Re: Proposed policy feature: $1_domain attribute
> 
> On Tue, 2005-03-01 at 12:31 -0500, Stephen Smalley wrote:
> >On Tue, 2005-03-01 at 12:29 -0500, Ivan Gyurdiev wrote:
> >> Well, in that case, how about an attribute to marks all of the 
> >> programs that have less permissions than the user. You said Tresys 
> >> has done inheritance work that can verify this stuff automatically.
> >
> >Not sure that their notion of inheritance will apply here, as it is:
> >1) name-based, i.e. type A.B.C is bounded by the permissions 
> allowed to 
> >type A.B and type A.B is bounded by the permissions allowed 
> to type A,
> >2) strict, i.e. type A.B.C cannot any permissions to type D 
> unless type 
> >A has those permissions, whereas program domains have often some 
> >additional permissions even if we consider them to be less 
> privileged 
> >for their own private objects,
> >3) likely to cut across domains differently than you 
> envision, as it is 
> >intended to allow delegation of management of portions of 
> the policy, 
> >e.g. the entire apache policy, without being able to alter 
> properties 
> >of the base policy (as bounded by the overall "apache" type).
> 
> I'm tempted to try and put the policy in a database and write 
> SQL queries against that. :) There's too many rules - hard to 
> keep track of them all.
> 

I doubt that you really want to do that - it is likely to be both painful, slow,
and not actually answer a lot of your questions (e.g., how would you handle
attributes efficiently). I encourage you to look at Apol and libapol. Apol
provides searching and analysis features in a gui. If that doesn't meet your
needs you can write analysis programs against libapol. We have spent several
years creating this analysis infrastructure and have had to tackle some
difficult problems along the way. It is a good starting point for anyone trying
to analyze or understand a policy.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 


> --
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
