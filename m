Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Frank Mayer <mayerf@tresys.com>,
   "'Colin Walters'" <walters@verbum.org>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <20041105162951.GD5565@lkcl.net>
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
	 <418B968F.3070700@trustedcs.com>  <20041105162951.GD5565@lkcl.net>
Content-Type: text/plain
Message-Id: <1099673084.6373.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 11:44:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 11:29, Luke Kenneth Casson Leighton wrote:
>  however, are there already asserts covering domain_auto_trans?
> 
>  the same logic would apply, yes?

The same logic is "Write your policy carefully, and check it well (using
assertions, apol, etc.)"  It isn't to hardcode a specific logic in the
kernel mechanism.  Consider unconfined_domain() and the targeted policy;
should the kernel mechanism have prohibited the creation of policies
that include it?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
