Subject: Re: dynamic context transitions
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Chad Hanson <chanson@TrustedCS.com>, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1099658949.6373.28.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
	 <20041103172609.GE5061@lkcl.net>
	 <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
	 <1099632701.25416.19.camel@nexus.verbum.private>
	 <1099658949.6373.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 11:01:01 -0500
Message-Id: <1099670461.25416.39.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 07:49 -0500, Stephen Smalley wrote:

> That's a policy issue; it doesn't affect the mechanism implementation in
> the kernel.  Tresys is doing work on language extensions that would help
> support such restrictions, but that work is purely userspace; the policy
> will still be compiled down to the existing form for the kernel.

Right, that makes sense.  I just want to make it hard to write "bad"
dynamic transitions.  Also, having this enforced by checkpolicy means
that analysis tools like apol can by default ignore subtypes, and show
flow based on the maximal type.  Then there would be e.g. a checkbox in
the Types/Attributes tab of Policy Rules to show the subtypes for a
particular maximal type.  Similarly for the Analysis tab.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
