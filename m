Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
In-Reply-To: <1168632626.13080.212.camel@code.and.org>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 16:01:32 -0500
Message-Id: <1168635692.7993.581.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:
>  I never saw the original discussion, but I'm 99% sure I complained to
> Jim and/or Dan that cp -a/-p should do "the right thing" and preserve
> everything, when I was adding the xattr support.
>  Note that the changes in question are not really consistent:
> 
> 
>                FC-5           FC-6            rawhide          
> 
> mode = acls[1] yes            yes             no
> -p             trad.          trad.           trad.+acls+xattrs
> -a             -dpPR          -dpPRc          -dpPR
> --preserve=all trad.+context  trad.+context   trad.+context+acls+xattrs
> 
> ...and in FC-6 -Z also does the open+getfscreatecon+fsetfilecon dance.

Polite request:  When changes to the selinux functionality in packages
like coreutils are being proposed, please bring them to this list for
discussion so that we can (hopefully) catch these kinds of issues early.

Would it help to host the current selinux userland patches on the
sourceforge selinux project?  Digging a canonical set out of the Fedora
CVS might take a fair amount of work as one would need to coalesce the
multiple separate selinux-related patches that exist for some packages
and re-base them to a clean upstream package if possible.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
