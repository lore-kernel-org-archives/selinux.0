Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n36HVlDu025730
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 13:31:47 -0400
Received: from brmea-mail-4.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n36HVktB000439
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 17:31:46 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by brmea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n36HVj71015488
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 17:31:45 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n36HVjQi055459
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 11:31:45 -0600 (MDT)
Date: Mon, 6 Apr 2009 11:22:26 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Santosh Chokhani <SChokhani@cygnacom.com>
Cc: Kurt Zeilenga <Kurt.Zeilenga@Isode.com>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfsv4@ietf.org, saag@ietf.org,
        nfs-discuss@opensolaris.org
Subject: Re: [saag] Common labeled security          (comment on CALIPSO, labeled NFSv4)
Message-ID: <20090406162226.GX1500@Sun.COM>
References: <20090402154402.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com> <20090403164522.DEA9A9A4739@odin.smetech.net> <9C2457A4-328A-4A68-A9D2-6E4B5544078D@Isode.com> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFE0@scygexch1.cygnacom.com> <B8FB99E8-17AA-4D4B-A309-8AF79838A304@Isode.com> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFE9@scygexch1.cygnacom.com> <20090406151606.GQ1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48AA0032@scygexch1.cygnacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FAD1CF17F2A45B43ADE04E140BA83D48AA0032@scygexch1.cygnacom.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 06, 2009 at 11:51:38AM -0400, Santosh Chokhani wrote:
> Either you need equivalency or not.
> 
> If you do not, that part of SPIF can be stripped off.
> 
> If you do need one, the complexity, scalability, and interoperability of
> other alternatives should be assessed against SPIF approach.

Indeed.  I think, however, that it will be necessary to support policies
parts of which are classified differently from each other.  It'd be nice
to be able to get rid of such a complication.

But you can see why this is needed.  Remember that during WWII very few
people on the Allied side knew about some of the cryptanalysis efforts
being made, and, IIRC, all such information was classified as "Ultra"
and no one who didn't have Ultra clearance was allowed to know that
Ultra existed (presumably because public knowledge of such a
classification might have caused the enemy to wonder).

Today the names and existence of specific compartments rather than
specific sensitivity level, are likley to be the cause of thie
requirement.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
