Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Chad Hanson <chanson@TrustedCS.com>, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1099632701.25416.19.camel@nexus.verbum.private>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
	 <20041103172609.GE5061@lkcl.net>
	 <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
	 <1099632701.25416.19.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1099658949.6373.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 07:49:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 00:31, Colin Walters wrote:
> There seemed to be a consensus behind restricting dynamic transitions to
> within a "domain hierarchy"; i.e. that an application could not
> dynamically gain more privileges, only shed them.  Is that true?  And if
> so, what will the language to define them look like?

That's a policy issue; it doesn't affect the mechanism implementation in
the kernel.  Tresys is doing work on language extensions that would help
support such restrictions, but that work is purely userspace; the policy
will still be compiled down to the existing form for the kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
