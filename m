Subject: Re: dynamic context transitions
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Chad Hanson <chanson@TrustedCS.com>, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
	 <20041103172609.GE5061@lkcl.net>
	 <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 00:31:40 -0500
Message-Id: <1099632701.25416.19.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 11:50 -0500, Stephen Smalley wrote:

> I would like to move forward with this proposal, going beyond a
> discussion of whether or not it should be implemented to how it should
> be implemented. 

There seemed to be a consensus behind restricting dynamic transitions to
within a "domain hierarchy"; i.e. that an application could not
dynamically gain more privileges, only shed them.  Is that true?  And if
so, what will the language to define them look like?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
