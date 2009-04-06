Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n36GPVVQ016460
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 12:25:31 -0400
Received: from sca-ea-mail-2.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n36GPUBS028464
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 16:25:30 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by sca-ea-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n36GPPvF011938
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 16:25:25 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n36GPPbs001867
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 10:25:25 -0600 (MDT)
Date: Mon, 6 Apr 2009 10:16:06 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Santosh Chokhani <SChokhani@cygnacom.com>
Cc: Kurt Zeilenga <Kurt.Zeilenga@Isode.com>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfsv4@ietf.org, saag@ietf.org,
        nfs-discuss@opensolaris.org
Subject: Re: [saag] Common labeled security          (comment on CALIPSO, labeled NFSv4)
Message-ID: <20090406151606.GQ1500@Sun.COM>
References: <20090402154402.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com> <20090403164522.DEA9A9A4739@odin.smetech.net> <9C2457A4-328A-4A68-A9D2-6E4B5544078D@Isode.com> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFE0@scygexch1.cygnacom.com> <B8FB99E8-17AA-4D4B-A309-8AF79838A304@Isode.com> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFE9@scygexch1.cygnacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FAD1CF17F2A45B43ADE04E140BA83D48A9FFE9@scygexch1.cygnacom.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 06, 2009 at 07:03:32AM -0400, Santosh Chokhani wrote:
> I view SPIF as performing the following functions: converting machine to
> human representation and vice versa; establishing equivalency between
> two labeling policies, and defining which labels with the lattice are
> valid and which are invalid.

If I understand Russ' comment correctly the difficulty with SPIF lies in
the label equivalency concept.  I think there's a better solution for
dealing with the idea that parts of a policy are classified differently
than others.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
