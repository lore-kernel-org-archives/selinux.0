Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n33HrXuW016285
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 13:53:33 -0400
Received: from sca-ea-mail-4.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n33HrWBk015740
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 17:53:32 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by sca-ea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n33HrVNs029130
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 17:53:31 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n33HrVWB041506
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 11:53:31 -0600 (MDT)
Date: Fri, 3 Apr 2009 11:51:44 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Russ Housley <housley@vigilsec.com>
Cc: Santosh Chokhani <SChokhani@cygnacom.com>, saag@ietf.org,
        labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov, nfsv4@ietf.org,
        nfs-discuss@opensolaris.org
Subject: Re: [saag] Common labeled security (comment on CALIPSO, labeled NFSv4)
Message-ID: <20090403165143.GC1500@Sun.COM>
References: <20090402154402.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com> <20090403164522.DEA9A9A4739@odin.smetech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090403164522.DEA9A9A4739@odin.smetech.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 03, 2009 at 12:44:30PM -0400, Russ Housley wrote:
> I really do not have time to write about all of my 
> concerns.  However, once you get beyond the basic classifications, 
> the SPIF model breaks.  They are markings that are only to be known 
> to people that have the clearance for those markings, this leads to a 
> SPIF distribution nightmare, as a subset of the real SPIF must be 
> given out based on access (or not) to various compartments and 
> such.  It just does not scale.

I'm aware of the fact that labels can themselves be labeled.  But I
don't think that implies that we can't make a SPIF-like solution scale.

Peers that have access to different subsets of the policy should still
be able to interop if care is taken to specify what happens when a node
sees a label that falls outside its policy subset, and provided, of
course, that the peers can agree that they have subsets of the *same*
master policy.  Peers can check whether they do have subsets of the
*same* master policy by exchanging [for each DOI to both] a master
policy URI that includes a version number.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
