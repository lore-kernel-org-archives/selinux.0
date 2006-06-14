Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
	mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
In-Reply-To: <448F0B3C.20901@trustedcs.com>
References: <447DD3D7.4050200@trustedcs.com>
	 <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>
	 <447EF602.5080003@trustedcs.com>
	 <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
	 <4480500E.10906@trustedcs.com>
	 <1149262527.524.503.camel@moss-spartans.epoch.ncsc.mil>
	 <448F0B3C.20901@trustedcs.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 11:02:39 -0400
Message-Id: <1150297359.25236.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-13 at 14:00 -0500, Darrel Goeddel wrote:
> I am also not really concerned about it.  Shall we give this a whirl in the
> lspp kernel (since its users are currently exercising the problematic code
> path) and include push it through the audit git tree if it works nicely?
> Note that this would replace the band-aid patch that is currently included
> in the lspp kernel.  Anyone object (or have a patch using the callback
> method)?

No objection from me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
