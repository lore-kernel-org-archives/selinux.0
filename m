Message-Id: <200404141310.i3EDAlJx015401@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 09:11:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200404140917.01773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Russell Coker
> Sent: Tuesday, April 13, 2004 7:17 PM
> To: Daniel J Walsh
> Cc: SELinux
> Subject: Re: Now that SELinux supports booleans should we replace tunables
> with booleans?
> 
> On Tue, 13 Apr 2004 23:59, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Ideas?
> 
> For most items in tunable.te they won't be changed often or for small
> reasons.
> In some cases changing tunable.te will require application restart (or
> system
> reboot) to fully take affect.
> 

Why is a reboot required?

> The aim of booleans is for things that are designed to be transient (EG
> secure
> levels).
> 

I don't agree completely with this. Booleans allow well defined policy
changes to be made by domains without policy compilation and reloading
privileges. In order to use the tunables, a user/domain must have full
access to change anything about the policy. With the booleans a user can be
authorized to change a portion of the policy in a specific way without any
other policy privileges. This seems like an important advantage to me.

> Also if we use booleans for tunables we need to have boolean support for
> role
> and domain transitions (currently not implemented), and a mechanism for
> preserving boolean values across a reboot.
> 

There is full support for type transition rules - the current Boolean
example (ping.te) in the NSA policy uses the domain_auto_trans macro within
a conditional block.

It is true that there isn't support for role statements in conditional
blocks, but it is not clear that authorizing a role for a type represents is
security risk if there are no rules that allow that role to reach the type
(again, see the ping.te example - user_r is authorized for ping_t but can
only reach it if user_ping is true). Hopefully role and role transition
statements will be supported in conditional statements soon, but it doesn't
seem like a large reason not to use the booleans for now.

As far as preserving boolean values, this doesn't seem any different from
other runtime kernel values and there are mechanism that can be easily
extended to handle this.

Karl

> I think it's best to continue with tunables the way they are.
> 

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
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
