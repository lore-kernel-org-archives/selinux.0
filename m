Subject: Re: [PATCH][origin/autotools] fix libtool_compat header error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Vikram Noel Ambrose <noel.ambrose@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BFEC01.3080603@manicmethod.com>
References: <48B6FD13.1000204@windriver.com>
	 <48BF4023.7010007@manicmethod.com> <48BF5551.5080702@gmail.com>
	 <48BFEC01.3080603@manicmethod.com>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 10:18:48 -0400
Message-Id: <1220537928.17197.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-09-04 at 10:09 -0400, Joshua Brindle wrote:
> Vikram Noel Ambrose wrote:
> > Joshua Brindle wrote:
> >> Vikram Ambrose wrote:
> <snip> 
> > Oh before i forget. It would be nice to add NEWS, README and AUTHORS
> > files to each package folder, no mandatory, but would make life easier,
> > as these files need to be generated before autoconf can be run, and it
> > would be better to have meaningful content for these files then stubbing
> > it out on the fly from the autogen.sh script. If there is no objection I
> > will create a separate commit for these files.
> > 
> 
> I removed them from the previous patch because they were incomplete
> and may have been seen as offensive to some (eg., the AUTHORS file
> only had you and I listed). There are quite a few contributors to this
> code and I'm not even sure if I could collect them all. Steve might be
> able to though, since he has some sort of bionic brain.

We could likely generate an approximate list from a combination of the
Author comments in the source files and the ChangeLog files.

Cast of thousands, including but not limited to:
...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
