Subject: Re: odd behavior of newrole setting level
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Andy Warner <warner@rubix.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <2059284C-AF69-4AEE-B1D9-94C6AA7C60E8@nall.com>
References: <4B5FAF0A.8070402@rubix.com> <4B604A21.4060000@redhat.com>
	 <2059284C-AF69-4AEE-B1D9-94C6AA7C60E8@nall.com>
Content-Type: text/plain
Date: Wed, 27 Jan 2010 15:36:03 -0500
Message-Id: <1264624563.17372.94.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-27 at 10:14 -0600, Joe Nall wrote:
> On Jan 27, 2010, at 8:13 AM, Daniel J Walsh wrote:
> 
> > On 01/26/2010 10:12 PM, Andy Warner wrote:
> >> Can someone explain why the first newrole (newrole -l s0) from the
> >> commands below fails while the second newrole (newrole -l SystemLow)
> >> succeeds. I am using Fedora 12 fully updated, the mls policy and the
> >> mcstrans label translation service. s0 is mapped to SystemLow.
> >> 
> >> Thanks,
> >> 
> >> Andy
> >> 
> >> $ id -Z
> >> staff_u:staff_r:staff_t:SystemLow-SystemHigh
> >> $ newrole -l s0
> >> staff_u:staff_r:staff_t:s0-SystemHigh is not a valid context
> >> $ newrole -l SystemLow
> >> Password:
> >> $ id -Z
> >> staff_u:staff_r:staff_t:SystemLow-SystemHigh
> >> $ newrole -l s0-s0
> >> Password:
> >> $ id -Z
> >> staff_u:staff_r:staff_t:SystemLow
> >> 
> >> 
> >> 
> >> 
> >> 
> > Looks like a bug in mcstrans.
> 
> I'll take a look. I can duplicate the behavior.

Perhaps mcstrans doesn't try any translation of the high level if the
low level is already in raw/kernel form?

What is happening as far as newrole is concerned is this:
- It fetches the caller's context via getprevcon, getting
"SystemLow-SystemHigh" due to mcstrans running,
- It then builds a new range using the user-supplied level ("s0") and
the high level from the caller's range ("SystemHigh"), thus forming
"s0-SystemHigh" as the new range.  This is because newrole only changes
the current/low level by default, leaving the clearance/high level
unchanged.
- It combines that with the rest of the context, and calls
security_check_context() to check validity.

mcstrans should then translate it to s0-s15:c0.c1024 or whatever, but
appears to be yielding the identity function on it instead.

newrole could of course use getprevcon_raw() instead, but then we might
have a reverse mixture, e.g. SystemLow-s15:c0.c1024 in the newrole -l
SystemLow case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
