Message-Id: <200509161819.j8GIJUWi010858@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] fix checkpolicy segfaults when using role dominancestatements
Date: Fri, 16 Sep 2005 14:19:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1126892199.27393.45.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Friday, September 16, 2005 1:37 PM
> To: Darrel Goeddel
> Cc: Joshua Brindle; selinux@tycho.nsa.gov
> Subject: Re: [PATCH] fix checkpolicy segfaults when using role
> dominancestatements
> 
> On Thu, 2005-09-15 at 16:52 -0500, Darrel Goeddel wrote:
> > This patch fixes two segfaults in the code path handling a
> > role dominance statement such as:
> >
> > dominance { role big_r { role little_r; } }
> >
> > Look correct?
> 
> Thanks, merged.  It would likely help if there was a real user of role
> dominance in the example policy (and reference policy) so that this code
> path is exercised on a regular basis.
> 

We have discussed using role dominance in reference policy but so far have
not made a large effort in that direction. The idea was that you could
create a large number of fine grained roles - down to the level of a role
for an individual module - and then use dominance to create the higher level
roles. This would make it much simpler to create new roles without having to
add a large number of role statements throughout the policy. Any thoughts on
whether this would work (other than not working because of broken code that
is)?

Karl 

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
