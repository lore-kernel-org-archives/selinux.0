Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Frank Mayer <mayerf@tresys.com>,
   "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1099668785.20150.139.camel@pham.columbia.tresys.com>
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
	 <418B968F.3070700@trustedcs.com>
	 <1099668037.6373.126.camel@moss-spartans.epoch.ncsc.mil>
	 <1099668785.20150.139.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099668922.6373.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 10:35:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 10:33, Karl MacMillan wrote:
> It seems to depend on whether most distributions are going to compile it
> in or not. If it is rarely enabled - like MLS - then I would just assume
> it be compile time. If most distributions expect to turn it on I would
> rather see it always compiled. Do you anticipate the permissions to
> always be present - and I assume this will be policy version 19?

I'd be surprised if the major distros would disable it vs. just control
it via policy.  It doesn't require a new policy version; you can always
add new permissions and classes without affecting that.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
