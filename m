Message-Id: <200404141410.i3EEA0Jx015621@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Russell Coker'" <russell@coker.com.au>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Wed, 14 Apr 2004 10:10:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1081949423.23747.32.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
> Sent: Wednesday, April 14, 2004 9:30 AM
> To: Karl MacMillan
> Cc: Russell Coker; 'Daniel J Walsh'; 'SELinux'; 'Selinux Dev'
> Subject: RE: Now that SELinux supports booleans should we replace
> tunableswith booleans?
> 
> On Wed, 2004-04-14 at 09:11, Karl MacMillan wrote:
> > As far as preserving boolean values, this doesn't seem any different
> from
> > other runtime kernel values and there are mechanism that can be easily
> > extended to handle this.
> 
> So you are suggesting something akin to /etc/sysctl.conf for boolean
> values and running something akin to sysctl -p from /etc/rc.d/rc.sysinit
> to set the boolean value during initialization?
> 

Sure - init should have the privileges to do this. The only detail is that
this should be done before any daemons are started - is rc.sysinit run early
enough?

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
