Subject: Re: selinux testsuite
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@redhat.com>, kaigai@ak.jp.nec.com,
        ltp-list <ltp-list@lists.sf.net>
In-Reply-To: <20100701195352.GA26918@hallyn.com>
References: <20100629195210.GA14549@hallyn.com>
	 <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
	 <1277909544.21903.142.camel@moss-pluto.epoch.ncsc.mil>
	 <1278003976.21642.4.camel@subratamodak.linux.ibm.com>
	 <1278008699.15753.195.camel@moss-pluto.epoch.ncsc.mil>
	 <20100701195352.GA26918@hallyn.com>
Content-Type: text/plain
Date: Sat, 03 Jul 2010 23:27:50 +0530
Message-Id: <1278179871.7665.11.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-01 at 14:53 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Thu, 2010-07-01 at 22:36 +0530, Subrata Modak wrote:
> > > On Wed, 2010-06-30 at 10:52 -0400, Stephen Smalley wrote: 
> > > > On Wed, 2010-06-30 at 17:43 +0530, Subrata Modak wrote:
> > > > > Hi Serge,
> > > > > 
> > > > > On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> > > > > > Just a little note to announce that the selinux testsuite is now up as a
> > > > > > git tree at kernel.org.  You can fetch it using
> > > > > > 
> > > > > > 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> > > > > 
> > > > > Great. So, how far does it differ from that we have in LTP ?
> > > > > http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD
> > > > > 
> > > > > As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
> > > > > main contributors to the SELinux test(s) in LTP, i guess the next/future
> > > > > development for SELinux tests will be happening in the new tree.
> > > > > 
> > > > > So, i would rather keep pulling to LTP from your tree. Now, could you
> > > > > please let me know:
> > > > > 
> > > > >      1. Whether the new tree contains all scenarios which is present in
> > > > >         LTP. In such a case a complete pruning of LTP SELinux tests can
> > > > >         be done and replaced with your tree contents,
> > > > >      2. If some of the LTP tests are not there, then i would like to
> > > > >         retain them in LTP side-by-side your tree contents,
> > > > 
> > > > The new tree contains all of the selinux tests present in the LTP.  You
> > > > cannot however simply replace the ltp version of the tests with this
> > > > tree, as this tree is a standalone testsuite and will not run within the
> > > > ltp test harness. This testsuite is based on the original standalone
> > > > selinux testsuite that was contributed by us to IBM to port to the LTP.
> > > > We have internally maintained this testsuite in parallel to the ltp
> > > > version as we have found it easier to set up, use, debug, and maintain.
> > > 
> > > Thanks Stephen. Since you have maintained the Original-One Internally
> > > and have simultaneously contributed changes to the LTP-version of
> > > SELinux, i am depending on you/Serge/SELinux-Mailing-List-members to
> > > keep sending patches to LTP to update the LTP-version at regular
> > > intervals (off-course at your convenience ;-))
> > 
> > I think that will depend on whether there is some benefit to maintaining
> > the ltp version.  We might derive some benefit if the ltp selinux
> > testsuite were better integrated (e.g. tests run by default if SELinux
> > is enabled on the host) and if the tests got some regular attention from
> > the ltp maintainers.  Otherwise, it may be better to just remove the
> > tests from the ltp and point people to the standalone version.
> 
> I don't object to the tests being maintained in LTP.  But so far, AFAICS,
> the cost of maintaining in LTP far outweighs the benefits.
> 
> So I'd like to know, does anyone (IBM?) *use* the version in LTP for
> automated testing?

Yes, there are teams which still use LTP SELinux on Enterprise Distro
testing.

Regards--
Subrata

> 
> If not, heck we could replace ltp/testcases/kernel/security/selinux/*
> with a script that git clones the testsuite and runs it.
> 
> Mind you it's not the selinux tests per se - it's the random bulk LTP
> updates which then break selinux tests, or worse, the autoconf cruft
> to try to detect whether the user wants selinux tests - which constitute
> the real maintenance cost.
> 
> If someone who uses the LTP selinux tests could step up and offer
> to periodically run the tests and work with (me and) the community
> to push fixes, I'll be happy to help out.
> 
> -serge
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
