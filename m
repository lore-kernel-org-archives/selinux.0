Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LDFQrT000870
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 09:15:26 -0400 (EDT)
Received: from mail.idtweb.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LDFFNg013521
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 13:15:15 GMT
Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Joshua D. Guttman disp: slinux'" <guttman@mitre.org>,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>, <selinux@tycho.nsa.gov>,
   "'Amy L Herzog'" <aherzog@mitre.org>
Subject: RE: Fedora Core 2 setools RPM
Date: Mon, 21 Jun 2004 09:14:54 -0400
Message-ID: <004001c45791$d03b5400$4d0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <nhabrjg3bpe.fsf@malabar.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> So in some sense the bottom line is that you think the type relations
> give the essential core of the policy info, and to a first
> approximation one can focus on that.
> 
> Of course, it's still desirable to have access to the supplementary
> information (and an idea how to interpret it) so that the further
> refinement will eventually work out.

I will assert rather strongly that a transitive analysis of flows between given
types is the nearly the entire concern.  Filters on that analysis make the
analysis practical, and the most important filters we have learned are interim
types (i.e., "trusted" types), object classes, and permissions and permissions
weights.  Libapol supports all of this.  

Constraints IMHO are like other orthogonal security mechanisms (such as
protection modes); they can add further restrictions but are not part of the
fundamental TE policy.  Role context restrictions are the same.  Some day we may
get to them (as well as checking for access modes and indeed if types are even
applied to real objects), but these issues are not critical to the goal.  Our
thrust, now that we have implemented most of the critical filters that we have
identified through analysis experience, is to provide a batching capability to
allow re-analysis and modeling of security properties.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
