Message-Id: <200503071510.j27FAJ8R011856@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: "'Thomas Bleher'" <bleher@informatik.uni-muenchen.de>,
   <selinux@tycho.nsa.gov>
Subject: RE: Proposed policy feature: $1_domain attribute
Date: Mon, 7 Mar 2005 10:10:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1109698283.10589.71.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Stephen Smalley
> Sent: Tuesday, March 01, 2005 12:31 PM
> To: Ivan Gyurdiev
> Cc: Thomas Bleher; selinux@tycho.nsa.gov
> Subject: Re: Proposed policy feature: $1_domain attribute
> 
> On Tue, 2005-03-01 at 12:29 -0500, Ivan Gyurdiev wrote:
> > Well, in that case, how about an attribute to marks all of the 
> > programs that have less permissions than the user. You said 
> Tresys has 
> > done inheritance work that can verify this stuff automatically.
> 
> Not sure that their notion of inheritance will apply here, as it is:
> 1) name-based, i.e. type A.B.C is bounded by the permissions 
> allowed to type A.B and type A.B is bounded by the 
> permissions allowed to type A,
> 2) strict, i.e. type A.B.C cannot any permissions to type D 
> unless type A has those permissions, whereas program domains 
> have often some additional permissions even if we consider 
> them to be less privileged for their own private objects,
> 3) likely to cut across domains differently than you 
> envision, as it is intended to allow delegation of management 
> of portions of the policy, e.g. the entire apache policy, 
> without being able to alter properties of the base policy (as 
> bounded by the overall "apache" type).
> 

One further note - there is no inheritance of permissions in this model, only of
constraints. A newly declared subtype has no access until it appears in rules.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  

> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
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
