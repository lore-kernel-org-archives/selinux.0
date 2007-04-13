Subject: Re: [PATCH]: add boolmap argument to expand_module_avrules()
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1176473519.3986.221.camel@moss-spartans.epoch.ncsc.mil>
References: <1176404597.9840.65.camel@sgc>
	 <1176473519.3986.221.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 12:19:27 -0400
Message-Id: <1176481167.8230.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-13 at 10:11 -0400, Stephen Smalley wrote:
> On Thu, 2007-04-12 at 19:03 +0000, Christopher J. PeBenito wrote:
> > A recent change to libsepol's expander introduced the boolmap structure
> > so that boolean values may be remapped properly.

Just a note - other identifiers likely need similar treatment (like
users and roles). Anyone want to volunteer to fix this?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
