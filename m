From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <james.antill@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Tim Waugh <twaugh@redhat.com>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
In-Reply-To: <1168635692.7993.581.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Fri, 12 Jan 2007 16:01:32 -0500")
References: <45A7D773.8040800@redhat.com>
	<1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	<1168632626.13080.212.camel@code.and.org>
	<1168635692.7993.581.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 12 Jan 2007 22:29:46 +0100
Message-ID: <87k5zsexx1.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:
>>  I never saw the original discussion, but I'm 99% sure I complained to
>> Jim and/or Dan that cp -a/-p should do "the right thing" and preserve
>> everything, when I was adding the xattr support.
>>  Note that the changes in question are not really consistent:
>>
>>
>>                FC-5           FC-6            rawhide
>>
>> mode = acls[1] yes            yes             no
>> -p             trad.          trad.           trad.+acls+xattrs
>> -a             -dpPR          -dpPRc          -dpPR
>> --preserve=all trad.+context  trad.+context   trad.+context+acls+xattrs
>>
>> ...and in FC-6 -Z also does the open+getfscreatecon+fsetfilecon dance.
>
> Polite request:  When changes to the selinux functionality in packages
> like coreutils are being proposed, please bring them to this list for
> discussion so that we can (hopefully) catch these kinds of issues early.

Of course.

> Would it help to host the current selinux userland patches on the
> sourceforge selinux project?  Digging a canonical set out of the Fedora
> CVS might take a fair amount of work as one would need to coalesce the
> multiple separate selinux-related patches that exist for some packages
> and re-base them to a clean upstream package if possible.

I've done most of that merge for coreutils (but may lack some recent
patches) and the result will soon appear on a topic branch of the
upstream coreutils git repository:

  http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=summary

I've done this work independently of the coreutils-6.7 rawhide merge
that someone (Tim Waugh?) must have done recently, so it will be a good
cross-check to compare when I'm done.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
