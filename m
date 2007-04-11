Subject: Re: X server won't start using MLS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <9f066ee90704111235n5cadfc03s66230aacf254156d@mail.gmail.com>
References: <9f066ee90704111136w5e98b87bxf2463754621cf6fb@mail.gmail.com>
	 <1176317391.3986.44.camel@moss-spartans.epoch.ncsc.mil>
	 <9f066ee90704111229n4e876e00kd5a5722ff00141ad@mail.gmail.com>
	 <1176319951.3986.54.camel@moss-spartans.epoch.ncsc.mil>
	 <9f066ee90704111235n5cadfc03s66230aacf254156d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 15:45:16 -0400
Message-Id: <1176320716.3986.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-11 at 15:35 -0400, Mark Webb wrote:
> Sorry about the HTML.  I sometimes forget Gmail defaults to HTML.
> One question for you, will running audit2allow 'break' the MLS posture
> of the machine?

Hmmm...per your messages file, gdm-binary is running in initrc_t,
whereas it would normally be running in xdm_t.  Looks like the -mls
policy in Fedora doesn't even include the definitions for the X-related
domains (unlike the -strict policy).  So I think you need to build your
own policy from upstream refpolicy if you want X support.

Running audit2allow won't affect the MLS constraints, but the real
question is whether you can actually use X in a MLS environment without
XACE/XSELinux; you'd be limited to single-level-at-a-time desktop.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
