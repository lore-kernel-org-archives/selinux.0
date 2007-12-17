Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jburke@redhat.com
Cc: James Morris <jmorris@redhat.com>, Joy Latten <latten@us.ibm.com>,
        Daniel Walsh <dwalsh@redhat.com>, subrata@linux.vnet.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        Robert Williamson <robbiew@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Larson <plars@us.ibm.com>
In-Reply-To: <1197916993.17307.81.camel@moss-spartans.epoch.ncsc.mil>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
	 <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
	 <4761CF71.1020101@redhat.com>
	 <1197916993.17307.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 13:50:23 -0500
Message-Id: <1197917423.17307.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-17 at 13:43 -0500, Stephen Smalley wrote:
> On Thu, 2007-12-13 at 19:33 -0500, Jeff Burke wrote:
> > Stephen, Joy, Dan and James
> > 	Using Stephens latest patch. Here are the results for the selinux tests
> > ltp-full-20071130, RHEL5.1 + selinux-policy-2.4.6-106.el5_1.3:
> 
> Reverting the prior patches and applying this one instead, I am able to
> run all of the test cases successfully on RHEL5.1 with that policy
> version.
> 
> I never did get a failure on SELinux10 though even with the old patch.
> Looking at your log file, it suggests that you were running the tests
> without a controlling tty?  That will break that particular test at
> least (sendsigio_task).
> 
> As for the build failure on execshare_parent, I don't know how to fix
> that on ia64 - is there a portable way to write a call to clone(2) that
> will work there?  I don't have ia64 hardware readily available to me.

Ah, from the clone(2) man page, I see that one is supposed to use
clone2() instead on IA-64.  But someone else will have to do that and
test it - I don't have an ia64 machine at my disposal.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
