From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: CoreutilsBugs <bug-coreutils@gnu.org>,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?=
 <ovasik@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, yaneti@declera.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
In-Reply-To: <1254929412.2251.248.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 07 Oct 2009 11:30:12 -0400")
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	<87zl85bs0e.fsf@meyering.net>
	<1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil>
	<87d451boea.fsf@meyering.net> <87r5th7xd0.fsf@meyering.net>
	<1254919072.2251.186.camel@moss-pluto.epoch.ncsc.mil>
	<871vlfz7x3.fsf@meyering.net>
	<1254920045.2251.202.camel@moss-pluto.epoch.ncsc.mil>
	<87vdirxr7h.fsf@meyering.net>
	<1254929412.2251.248.camel@moss-pluto.epoch.ncsc.mil>
Date: Sat, 10 Oct 2009 11:59:27 +0200
Message-ID: <87ljjjh8n4.fsf@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2009-10-07 at 15:34 +0200, Jim Meyering wrote:
>> Stephen Smalley wrote:
>>
>> > On Wed, 2009-10-07 at 14:48 +0200, Jim Meyering wrote:
>> >> Stephen Smalley wrote:
>> >> ...
>> >> > FWIW, there is a subtle difference here:
>> >> > - chcon can in fact work on a SELinux-disabled kernel, as you can still
>> >> > set the security.* extended attributes as long as the filesystem
>> >> > provides handlers for the security.* namespace.
>> >> > - runcon cannot work without a SELinux-enabled kernel, as only a
>> >> > SELinux-enabled kernel allows you to set the security context of a
>> >> > running process.
>> >> >
>> >> > So by preventing chcon from running in the SELinux-disabled case, you
>> >> > are imposing a restriction above and beyond what is strictly required.
>> >> > The user can of course still use setfattr -n security.selinux -v
>> >> > <context> <path> to set a SELinux security context on a file when
>> >> > SELinux is disabled, or can run the setfiles program to set SELinux
>> >> > security contexts on an entire file tree even when SELinux is disabled.
>> >> ...
>> >> >> diff --git a/src/chcon.c b/src/chcon.c
>> >> >> index fbfdb4d..c0da694 100644
>> >> >> --- a/src/chcon.c
>> >> >> +++ b/src/chcon.c
>> >> >> @@ -519,6 +519,10 @@ main (int argc, char **argv)
>> >> >>        usage (EXIT_FAILURE);
>> >> >>      }
>> >> >>
>> >> >> +  if (is_selinux_enabled () != 1)
>> >> >> +    error (EXIT_FAILURE, 0,
>> >> >> +           _("%s may be used only on a SELinux kernel"), program_name);
>> >> >> +
>> >>
>> >> Thanks for the tip.
>> >> I'll revert that part of the patch.
>> >>
>> >> I'll address the original problem by adding
>> >> getfilecon and lgetfilecon wrappers that
>> >> map those unusual cases (10,"unlabeled" and 0,NULL)
>> >> to a return value of -1 with errno == ENOTSUPP.
>> >
>> > I'd suggest ENODATA instead - that means that the filesystem supports
>> > attributes but there was no value set for the particular file.
>>
>> ENODATA makes sense for the 10,"unlabeled" case.
>> I viewed "using a library so old that its getfilecon
>> can return 0 and set context to NULL" as lacking support (ENOTSUPP).
>> But I'll do whatever is more consistent with the rest of SELinux.
>
> Ah, I see - we did change getfilecon() in libselinux in 2007 to check
> for a return value of zero from getxattr() and map that to -1 with errno
> EOPNOTSUPP.  That was to address a change/regression in the kernel that
> caused getxattr() on /proc/sys nodes to return 0.  So I guess EOPNOTSUPP
> aka ENOTSUP is fine for the zero-return case.

I've resolved this via two changes:
One to add *getfilecon wrappers to gnulib:

    http://thread.gmane.org/gmane.comp.lib.gnulib.bugs/19037

and another to clean up coreutils, now that it can depend on
the wrappers' API-conforming behavior:

    http://thread.gmane.org/gmane.comp.gnu.coreutils.bugs/18454

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
