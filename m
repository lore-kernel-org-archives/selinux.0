Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Antill <james.antill@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <87ejpzgbnm.fsf@rho.meyering.net>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org> <87ps9keydd.fsf@rho.meyering.net>
	 <1168636912.7993.594.camel@moss-spartans.epoch.ncsc.mil>
	 <87ejpzgbnm.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 16:56:46 -0500
Message-Id: <1168639006.7993.606.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 22:47 +0100, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> [*] I resumed work on my coreutils selinux merge recently, so you should
> >> hear more about it soon -- on the bug-coreutils and bug-gnulib lists.
> >
> > It would be nice to have the actual diffs posted here.
> 
> It won't be hard to remember to Cc this list :)
> 
> BTW, last week I thought of you guys (with a smile :-) when I noticed new
> test failures and discovered that getfilecon and lgetfilecon now return
> length upon success -- at least with rawhide, whereas they returned 0
> a few months ago.  That shook out a few tests that were checking for
> nonzero rather that negative.

Returning the length was the original (and documented) behavior; the
returning 0 was a bug introduced by the MLS/MCS context translation
support in Fedora.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
