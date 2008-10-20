Subject: Re: [PATCH] selinux: new permission for chmod on suid or sgid files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, sgrubb@redhat.com
In-Reply-To: <1224275917.3189.63.camel@paris-laptop>
References: <1224258034.3189.25.camel@paris-laptop>
	 <1224262355.19562.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1224264294.19562.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8DCE3.3000805@redhat.com>
	 <1224269637.19562.115.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8E333.3060905@redhat.com>
	 <1224272365.19562.144.camel@moss-spartans.epoch.ncsc.mil>
	 <1224273875.3189.46.camel@paris-laptop>
	 <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
	 <1224275917.3189.63.camel@paris-laptop>
Content-Type: text/plain
Date: Mon, 20 Oct 2008 08:30:00 -0400
Message-Id: <1224505800.7428.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-17 at 16:38 -0400, Eric Paris wrote:
> Anyway, I'm not arguing this is going to provide greater MAC confinement
> and I'm not able to describe security goals in terms of MAC domains.
> I'm merely stating that a SELinux confined admin is easily able change
> DAC security policy as defined by an organization.

DAC by definition is subject to control by the user, not by the
organization.  

>   Yes, DAC sercurity
> policy that I'm talking about is mathmatically provable and that's the
> part that I'm sure you initially reject, but it doesn't make it
> pointless or even detractive.

It isn't about being provable but rather providing any actual security
benefit.

However, I'm open to the notion of controlling making additional
entrypoints to a user identity, as described in my response to Dan, but
I don't believe that this patch is the way to achieve that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
