Subject: Re: selinux testsuite
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: "Serge E. Hallyn" <serge@hallyn.com>, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@redhat.com>, kaigai@ak.jp.nec.com,
        ltp-list <ltp-list@lists.sf.net>
In-Reply-To: <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
References: <20100629195210.GA14549@hallyn.com>
	 <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Jun 2010 10:52:24 -0400
Message-ID: <1277909544.21903.142.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-30 at 17:43 +0530, Subrata Modak wrote:
> Hi Serge,
> 
> On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> > Just a little note to announce that the selinux testsuite is now up as a
> > git tree at kernel.org.  You can fetch it using
> > 
> > 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> 
> Great. So, how far does it differ from that we have in LTP ?
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD
> 
> As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
> main contributors to the SELinux test(s) in LTP, i guess the next/future
> development for SELinux tests will be happening in the new tree.
> 
> So, i would rather keep pulling to LTP from your tree. Now, could you
> please let me know:
> 
>      1. Whether the new tree contains all scenarios which is present in
>         LTP. In such a case a complete pruning of LTP SELinux tests can
>         be done and replaced with your tree contents,
>      2. If some of the LTP tests are not there, then i would like to
>         retain them in LTP side-by-side your tree contents,

The new tree contains all of the selinux tests present in the LTP.  You
cannot however simply replace the ltp version of the tests with this
tree, as this tree is a standalone testsuite and will not run within the
ltp test harness. This testsuite is based on the original standalone
selinux testsuite that was contributed by us to IBM to port to the LTP.
We have internally maintained this testsuite in parallel to the ltp
version as we have found it easier to set up, use, debug, and maintain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
