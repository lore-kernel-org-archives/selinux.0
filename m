Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gk4@us.ibm.com
Cc: jburke@redhat.com, James Morris <jmorris@redhat.com>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        Robert Williamson <robbiew@us.ibm.com>,
        Daniel Walsh <dwalsh@redhat.com>, klausk@br.ibm.com,
        Michael Reed <mreed10@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Joy Latten <latten@us.ibm.com>, Paul Larson <plars@us.ibm.com>
In-Reply-To: <1197908169.4834.7.camel@boilermaker.dyn.webahead.ibm.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
	 <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
	 <4761CF71.1020101@redhat.com>
	 <1197645067.31325.29.camel@moss-spartans.epoch.ncsc.mil>
	 <47635ED6.1010908@redhat.com>
	 <1197908169.4834.7.camel@boilermaker.dyn.webahead.ibm.com>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 13:08:35 -0500
Message-Id: <1197914915.17307.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-17 at 10:16 -0600, George Kraft wrote:
> On Fri, 2007-12-14 at 23:57 -0500, Jeff Burke wrote:
> > -----------------------------------------------
> > Total Tests: 38
> > Total Failures: 8
> > Kernel Version: 2.6.18-53.el5
> > Machine Architecture: i686
> > --------------------------------------------------------
> 
> Regarding the 8 selinux failures, are the problems with the OS, or the
> test cases?

It is test policy dependencies on the base policy being broken by
changes in the base policy.

As my patch yielded less failures, I'm looking at it further.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
