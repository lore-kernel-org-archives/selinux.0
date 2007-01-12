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
Date: Fri, 12 Jan 2007 15:24:54 -0500
Message-Id: <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:
> kOn Fri, 2007-01-12 at 13:55 -0500, Stephen Smalley wrote:
> > On Fri, 2007-01-12 at 13:46 -0500, Daniel J Walsh wrote:
> > > Currently in policy we do NOT have the following rule
> > > 
> > > allow iso9660_t fs_t:filesystem associate;
> > > 
> [...]
> > > Maybe a fix would be to allow cp to ask the kernel what to do if it can 
> > > not setfscreatecon a particular context on a file system.
> 
>  Note that copy.c uses fsetfilecon() on the open fd of the new file, but
> it saves the context of the old file in setfscreatecon() (and so does
> open+getfscreatecon+fsetfilecon). Fixing this to just store in a local
> variable would mean we'd see the error at setfilecon() time.

Hmm...I'm not sure about the precise history of the coreutils selinux
patch, but I had thought it was using setfscreatecon() as much as
possible to ensure that the file was labeled correctly at creation time.
Otherwise, the file can exist in the wrong label temporarily, which can
produce "false" denials (e.g. another process tries to access the file
before it is in the expected label and gets a denial) as well as "false"
grantings (e.g. another process tries to open the file before it is in
the right label and gets a descriptor - which is mitigated in part by
the revalidation of access on read/write/... calls and fd
inheritance/transfer but revocation support is incomplete). Note also
that the permission checks are different for creating vs. relabeling, so
the behavior affects policy.

Also, I'm not sure what you mean by the above, as I would expect that it
would do one of two things for preserving context:
1) getfilecon() on the original followed by setfscreatecon() to create
the copy in the same context immediately, or
2) getfilecon() on the original followed by creation of the new file
followed by setfilecon/fsetfilecon followed by writing data to the new
file.

Then there was the separate case of -Z where a particular context was
specified by the user, in which case you could just setfscreatecon() up
front to that value.

>  I never saw the original discussion, but I'm 99% sure I complained to
> Jim and/or Dan that cp -a/-p should do "the right thing" and preserve
> everything, when I was adding the xattr support.

I seem to recall earlier discussions where people found that
automatically enabling preservation of contexts upon -p and -a produced
a fair amount of breakage in practice, particularly under -strict
policy, because processes could very well be allowed to preserve DAC
information but not alter their own default MAC labeling behaviors.

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

Not sure what that dance is precisely.

> > I agree that allowing the association isn't the right thing to do.  Part
> > of the problem here is that setfscreatecon() doesn't know where you are
> > going to put the file, so it cannot report an error at that time, and
> > the open/mkdir failure could happen for a variety of reasons, not just
> > this one.
> 
>  So if we moved coreutils to just using fsetfilecon() for -p/-a, could
> we do something?

You don't have to do that; it just makes it clearer as to what failed.
But it does have other implications as well, as above.

> > cp could fall back to resetting fscreate to NULL and try again in that
> > case (as long as the user didn't explicitly request preservation via
> > --preserve=context).
> 
>  I'm not sure that's the right behaviour, I think the behaviour should
> be like if you copy an ACL to an FS that doesn't support them (Ie. it
> knows what failed, and why ... and so "does the right thing").

If the user/caller specifies to cp that it wants the security context
preserved, then any failure there should be fatal to the copy.  But if
the user/caller just specified -p or -a, which used to not include
security contexts, then it seems that an inability to preserve the
context shouldn't be fatal to the copy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
