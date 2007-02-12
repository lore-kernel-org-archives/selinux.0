Subject: Re: get_default_context_with_level seems to be broken in
	libselinux.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1171296969.5265.2.camel@moss-spartans.epoch.ncsc.mil>
References: <45D084AF.8020405@redhat.com>
	 <1171296969.5265.2.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 12:51:53 -0500
Message-Id: <1171302713.24318.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 11:16 -0500, Stephen Smalley wrote:
> On Mon, 2007-02-12 at 10:15 -0500, Daniel J Walsh wrote:
> > Bugzilla's 211827 224637 
> > <https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=224637>
> > 
> > Show that the values after the comma are being dropped.
> > 
> > Adding the attached patch fixes the problem.
> > 
> > But I am not sure of the intended use of this code.  The current code 
> > does not work and looks like it never worked.  Was there an intention 
> > that this would work differently?
> 
> If there is a bug, it needs to be fixed within
> get_ordered_context_list_with_level, not here.

Can you provide a test case to demonstrate the bug that doesn't involve
sshd, e.g. simple use of getdefaultcon from libselinux appears to work
as expected without your patch.
$ ./getdefaultcon -l s2:c0,c1 sds system_u:system_r:sshd_t:SystemLow-SystemHigh
./getdefaultcon: sds from system_u:system_r:sshd_t:SystemLow-SystemHigh
staff_u (null) s2:c0,c1 -> staff_u:staff_r:staff_t:Secret:A,B

Applying the patch and re-trying, the only visible difference is that
you end up with the untranslated level.  Is the problem in libselinux or
sshd (or mcstransd)?

Note that the current libselinux logic takes the provided level and puts
it into the fromcon before computing the set of reachable contexts so
that the levels are bounded by that level.  Rather than mutating the
level afterward.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
