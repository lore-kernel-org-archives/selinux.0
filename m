Message-Id: <200503071503.j27F348R011720@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>, "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Thomas Bleher'" <bleher@informatik.uni-muenchen.de>,
   <selinux@tycho.nsa.gov>
Subject: RE: Proposed policy feature: $1_domain attribute
Date: Mon, 7 Mar 2005 10:03:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1109714821.8401.11.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Ivan Gyurdiev
> Sent: Tuesday, March 01, 2005 5:07 PM
> To: Stephen Smalley
> Cc: Thomas Bleher; selinux@tycho.nsa.gov
> Subject: Re: Proposed policy feature: $1_domain attribute
> 
> On Tue, 2005-03-01 at 13:07 -0500, Ivan Gyurdiev wrote:
> >On Tue, 2005-03-01 at 12:31 -0500, Stephen Smalley wrote:
> >>On Tue, 2005-03-01 at 12:29 -0500, Ivan Gyurdiev wrote:
> >>> Well, in that case, how about an attribute to marks all of the 
> >>> programs that have less permissions than the user. You 
> said Tresys 
> >>> has done inheritance work that can verify this stuff 
> automatically.
> >>
> >>Not sure that their notion of inheritance will apply here, as it is:
> >>1) name-based, i.e. type A.B.C is bounded by the 
> permissions allowed 
> >>to type A.B and type A.B is bounded by the permissions 
> allowed to type 
> >>A,
> >>2) strict, i.e. type A.B.C cannot any permissions to type D unless 
> >>type A has those permissions, whereas program domains have 
> often some 
> >>additional permissions even if we consider them to be less 
> privileged 
> >>for their own private objects,
> >>3) likely to cut across domains differently than you 
> envision, as it 
> >>is intended to allow delegation of management of portions of the 
> >>policy, e.g. the entire apache policy, without being able to alter 
> >>properties of the base policy (as bounded by the overall 
> "apache" type).
> 
> It would be an interesting exercise to try to represent 
> SElinux as a graph, and use standard graph algorithms to 
> determine domain interactions... but in the meantime I'll 
> just do this the normal way - looking at the policy rules by hand :)
> 

My information flow work for Setools does just that - represents the policy as a
set of nodes with edges representing information flow. You can search the list
for some discussions of this with Mitre and, of course, look at the libapol
source.

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
