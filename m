Subject: Re: MLS translations for libsemanage and libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov, SELinux-dev@tresys.com
In-Reply-To: <437278BB.1000607@cornell.edu>
References: <20051109134021.GA27310@europium.cip.ifi.lmu.de>
	 <1131544327.20591.474.camel@moss-spartans.epoch.ncsc.mil>
	 <1131545169.20591.483.camel@moss-spartans.epoch.ncsc.mil>
	 <43721FCE.8050308@cornell.edu>
	 <1131552597.20591.554.camel@moss-spartans.epoch.ncsc.mil>
	 <437278BB.1000607@cornell.edu>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 07:30:17 -0500
Message-Id: <1131625817.20591.604.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 17:31 -0500, Ivan Gyurdiev wrote:
> What's the justification for doing translations in libselinux (the 
> library), while placing that responsibility on the caller for 
> libsemanage, and sepol. Maybe we should be doing translations for:

Translation is done in the context of a system's running policy, whereas
libsepol and libsemanage are operating on a policy object that may
differ from the system's running policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
