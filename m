Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA25135
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:23:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA03774
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 00:22:35 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA03770
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 00:22:34 GMT
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.)
	via ESMTP id QAA04133
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:23:46 -0800 (PST)
	mail_from (offer@morgaine.engr.sgi.com)
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [163.154.6.121])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id QAA64537
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:23:46 -0800 (PST)
Received: (from offer@localhost)
	by morgaine.engr.sgi.com (SGI-8.9.3/8.9.3) id QAA39403
	for selinux@tycho.nsa.gov; Tue, 26 Dec 2000 16:23:45 -0800 (PST)
From: "richard offer" <offer@sgi.com>
Message-Id: <1001226162345.ZM39431@sgi.com>
Date: Tue, 26 Dec 2000 16:23:44 -0800
In-Reply-To: =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d_=3Cmag=40bunuel=2Etii=2E?=
 =?iso-8859-1?Q?matav=2Ehu=3E?=
 =?iso-8859-1?Q?________=22Re=3A_=5Bselinux=5D_Re=3A_Mirror_Site=22_=28Dec?=
 =?iso-8859-1?Q?_27=2C_12=3A11am=29?=
References: <200012262148.QAA06775@coalstove.epoch.ncsc.mil>
	<20001227001116.A22887@bunuel.tii.matav.hu>
To: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: Mirror Site
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


* $ from mag@bunuel.tii.matav.hu at "27-Dec:12:11am" | sed "1,$s/^/* /"
*
*
* > Although the tools provided by Sourceforge are nice, we're hopeful that
* > the capabilities of our website, and the interaction provided by this
* > list will meet the needs of anyone who wants to work with the code.
* > If, as things progress, anyone believes that more support
* > infrastructure is required, please let us know.  We'll reexamine our
* > options if and when more is needed.
* >
*
* Having a project sourceforged is important not for just technical reasons.
* If the project is on sourceforge, it more likely attracts more developers
* and users, so the critical mass of the project is more easily reached.
* BTW, is there any official word (either from Linus or from NSA), when will
* flask integrated into the mainstream kernel sources? It is also a major
* issue from the "marketing" perspective. (I would be happy to see it in 2.5)

The continued addition of embryonic features to linux is what has kept 2.4 from
being released. This code has only been out for 2 days and is a research
project prototype at that, and we are already talking about adding it to the
main line ?


[ from the overview ]

  This work is not intended as a complete security solution for Linux.
  ...
  Instead, it is simply an example of how mandatory access controls that can
                           *******
  confine the actions of any process,
  including a superuser process, can be added into Linux. The focus of this
  work has not been on system assurance or other security features such
  as security auditing, although these elements are also important for a
  secure system.

Robert Watson (on the TrustedBSD list) says it best.

  Figuring out how the SELinux implementation fits into the bigger picture will
  be important -- it represents a large step forward in terms of the
  availability of secure open source operating systems.


This is good, interesting code, but that doesn't mean its ready for prime time
distribution yet.


I must be old, I'm getting too conservative....

richard.


-----------------------------------------------------------------------
Richard Offer          Widget FAQ --> http://reality.sgi.com/widgetFAQ/
{X,Motif,Trust} on {Irix,Linux}
__________________________________________http://reality.sgi.com/offer/

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
