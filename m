Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>,
        =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1241178723.27331.195.camel@localhost.localdomain>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
	 <1241032058.18249.277.camel@localhost.localdomain>
	 <op.us5xofaeu2flwt@debian>
	 <1241034001.18249.298.camel@localhost.localdomain>
	 <op.us51ezmiu2flwt@debian>
	 <1241087321.5983.12.camel@subratamodak.linux.ibm.com>
	 <1241097725.27331.13.camel@localhost.localdomain>
	 <1241178723.27331.195.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 May 2009 09:52:28 -0400
Message-Id: <1241531548.3023.301.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-01 at 07:52 -0400, Stephen Smalley wrote:
> On Thu, 2009-04-30 at 09:22 -0400, Stephen Smalley wrote:
> > On Thu, 2009-04-30 at 15:58 +0530, Subrata Modak wrote:
> > > On Wed, 2009-04-29 at 22:48 +0200, Jiří Paleček wrote:
> > > > On Wed, 29 Apr 2009 21:40:01 +0200, Stephen Smalley <sds@tycho.nsa.gov>  
> > > > wrote:
> > > > 
> > > > > On Wed, 2009-04-29 at 21:27 +0200, Jiří Paleček wrote:
> > > > >> On Wed, 29 Apr 2009 21:07:38 +0200, Stephen Smalley <sds@tycho.nsa.gov>
> > > > >> wrote:
> > > > >>
> > > > >> > On Sun, 2009-04-19 at 00:17 +0530, Subrata Modak wrote:
> > > > >> >> Stephen,
> > > > >> >>
> > > > >> >> Would you like to say something about the following Patch ?
> > > > >> >
> > > > >> > Yes, it breaks the selinux testsuite for me.  Please revert.
> > > > >>
> > > > >> How exactly does it break it?
> > > > >
> > > > > Running it via test_selinux.sh was generating errors like:
> > > > > cd: /testcases/bin: No such file or directory
> > > > > in selinux.outfile, producing a couple bogus FAILs.
> > > > 
> > > > This is probably caused by the line setting LTPBIN (which shouldn't have  
> > > > been there in the first place, my fault), does the attached patch fix it  
> > > > for you?
> > > 
> > > Nether applied this nor reverted the earlier one in this thread, as
> > > conclusion is yet to be made. But, i have to push the release today as i
> > > am going for a vacation for a couple of days. But, please send me the
> > > cleanups on consensus. I will do the needful when i return.
> > 
> > If you apply the re-based patch that I posted in response to his, then
> > at least that problem is solved - no need to revert his original patch.
> > 
> > I'd like to fork the refpolicy directory so that we can stop maintaining
> > diffs under selinux-testsuite/misc/ for post-rhel5 changes.  So if you
> > could create a copy of refpolicy under selinux-testsuite, say
> > "rhel5-refpolicy", and cvs add that to the tree, then we can work from
> > there.
> 
> Actually, I think I'd like to have a tree of test policies, e.g.
> refpolicy/trunk (test policy relative to refpolicy trunk)
> refpolicy/redhat/5 (test policy relative to rhel5)
> refpolicy/fedora/10 (test policy relative to fedora 10)
> refpolicy/debian/5 (test policy relative to debian 5.0)
> 
> Only I'm not sure we necessarily want one for every fedora release due
> to their short life cycles.  But it looks like the test policy for f11
> will be different than f10 (I have a patch to at least get it to build
> without warnings, but am still working through some test failures on
> f11).

Ok, I now have the selinux testsuite working on both f10 and f11 and
have set up a separate subdirectory to keep a legacy copy of the test
policy for rhel5.  I'll send a patch under separate cover.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
