Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n36GZLGP017640
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 12:35:21 -0400
Received: from sca-ea-mail-4.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n36GZKBS000336
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 16:35:20 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by sca-ea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n36GZJa6012921
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 16:35:19 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n36GZJwB009980
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 10:35:19 -0600 (MDT)
Date: Mon, 6 Apr 2009 10:11:01 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Sean Turner <turners@ieca.com>
Cc: Santosh Chokhani <SChokhani@cygnacom.com>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, saag@ietf.org, nfs-discuss@opensolaris.org,
        nfsv4@ietf.org
Subject: Re: [saag] Common labeled security (comment on CALIPSO,	labeled NFSv4)
Message-ID: <20090406151100.GP1500@Sun.COM>
References: <20090402154402.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com> <20090403154253.GZ1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF9E@scygexch1.cygnacom.com> <20090403173655.GK1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFAF@scygexch1.cygnacom.com> <20090403191838.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FFBE@scygexch1.cygnacom.com> <20090403195704.GT1500@Sun.COM> <49D80922.9050700@ieca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D80922.9050700@ieca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Apr 04, 2009 at 09:28:02PM -0400, Sean Turner wrote:
> I usually try to find the corresponding ITU spec because I think ITU 
> gives out all of it's ASN.1 modules freely?  Anyway, here's a link to 
> the ITU-T X.841 Spec:
> http://www.itu.int/ITU-T/asn1/database/itu-t/x/x841/2000/index.html

Thanks.  I'm sure the spec needs to be read too, not just the ASN.1
module (it's mostly self-evident, but some types, like
LabelAndCertValue, require an explanation).

> The one thing that's missing from the module is definitions for security 
> categories.  Some suggested categories were defined in Annex B, but it's 
> an informative annex so there's no ASN.1 freely available (they wouldn't 
> allow them in the normative text/module).  Those categories are based on 
> FIPS 188 (the syntax is not the same).
> 
> Note that some of the syntax for labels has made it's way to some 
> IDs/RFCs notably RFC 2634.

Thanks.  That's very useful.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
