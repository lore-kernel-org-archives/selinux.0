Subject: Re: [PATCH] audit validatetrans denials
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <4214C657.7@trustedcs.com>
References: <4213C115.3030703@trustedcs.com>
	 <1108647155.24494.18.camel@moss-spartans.epoch.ncsc.mil>
	 <4214C657.7@trustedcs.com>
Content-Type: text/plain
Message-Id: <1108657794.24494.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Feb 2005 11:29:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-17 at 11:29, Darrel Goeddel wrote:
> Yeah, I really could have made this nicer when I moved the functionality into 
> security_validate_transition (I originally had it another function which was 
> called after security_validate_transition)...  How about the attached patch instead.

Looks good, thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
