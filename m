Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJX8XZ011081
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:33:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJVnMb022311
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:31:49 GMT
Subject: Re: cdrecord patch [was: Re: cdrecord deadlocks linux 2.6.8.1
	(problem in setscheduler)]
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041018215802.GD2536@jmh.mhn.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
	 <20041018143842.GP19398@lkcl.net>  <20041018215802.GD2536@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:31:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-10-18 at 17:58, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-10-18 17:47]:
> > ah ha!  thomas, thank you v. much: i [badly] hacked up something
> > for k3b to use some time ago.
> > 
> > On Mon, Oct 18, 2004 at 02:43:32PM +0200, Thomas Bleher wrote:
> > 
> > > I have just written selinux policy for cdrecord. While writing this 
> > > policy cdrecord constantly locked up the computer (even in permissive
> > > mode). When booting with selinux=0 the problem went away.
> 
> Attached is an updated policy for inclusion into CVS. The previous
> version missed some permissions. With the current version I have
> successfully burnt a CD in enforcing mode.
> 
> Thomas
> 
> PS: This patch uses the can_resmgrd_connect() macro which was posted a
> while but is not yet in CVS. It can be removed if the other patch is not
> merged.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
