From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <james.antill@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
In-Reply-To: <1168636912.7993.594.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Fri, 12 Jan 2007 16:21:52 -0500")
References: <45A7D773.8040800@redhat.com>
	<1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	<1168632626.13080.212.camel@code.and.org>
	<87ps9keydd.fsf@rho.meyering.net>
	<1168636912.7993.594.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 12 Jan 2007 22:47:41 +0100
Message-ID: <87ejpzgbnm.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> [*] I resumed work on my coreutils selinux merge recently, so you should
>> hear more about it soon -- on the bug-coreutils and bug-gnulib lists.
>
> It would be nice to have the actual diffs posted here.

It won't be hard to remember to Cc this list :)

BTW, last week I thought of you guys (with a smile :-) when I noticed new
test failures and discovered that getfilecon and lgetfilecon now return
length upon success -- at least with rawhide, whereas they returned 0
a few months ago.  That shook out a few tests that were checking for
nonzero rather that negative.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
