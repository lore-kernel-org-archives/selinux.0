Message-Id: <200506301448.j5UEmP7f027939@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <gyurdiev@redhat.com>
Cc: "'Janak Desai'" <janak@us.ibm.com>, <selinux@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Thu, 30 Jun 2005 10:48:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1120139910.11798.58.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, June 30, 2005 9:59 AM
> To: gyurdiev@redhat.com
> Cc: Janak Desai; Karl MacMillan; selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: Re: file contexts and modularity
> 
> On Thu, 2005-06-30 at 09:53 -0400, Ivan Gyurdiev wrote:
> > I can see the problem being fixed if you label files under /home
> > _and_ /tmp with a ROLE independent-type. This will also remove the
> > need to relabel after a change in primary role, which is currently
> > a major issue. However, I wasn't sure if that was being suggested?
> > Is this what we're discussing here - removing role-dependent labeling,
> > since other roles' content will be hidden by polyinstantiation?
> 
> No, the derived types are still useful IMHO for isolation, and note that
> the polyinstantiated directory support doesn't try to prevent access to
> the other per-role directories (even when they are subdirectories of the
> top-level directory, we re-bind it elsewhere to allow security-aware
> applications to access it if allowed by policy and to allow programs
> like su and newrole to re-bind upon role changes).  On the other hand, I
> know Karl previously suggested eliminating them, but I think that would
> be a real loss...
> 

I don't remember suggesting their removal - must have been poor wording on my
part since you both misunderstood.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
