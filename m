Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l18Nm19N030733
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 18:48:01 -0500
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l18NnAa8006814
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 23:49:10 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l18NnAQk024607
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 18:49:10 -0500
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 3FAEBBF01
	for <selinux@tycho.nsa.gov>; Thu,  8 Feb 2007 18:49:10 -0500 (EST)
Received: from dreaming.mitre.org (dreaming.mitre.org [129.83.160.72])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with ESMTP id l18Nn8Q7024590
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 18:49:08 -0500
From: bsniffen@mitre.org (Brian T. Sniffen)
To: selinux@tycho.nsa.gov
Subject: MITRE releases Polgen 1.4
References: <1169394672.10741.2.camel@zeroKnowledge>
Date: Thu, 08 Feb 2007 18:48:01 -0500
In-Reply-To: <1169394672.10741.2.camel@zeroKnowledge> (Vincenzo Ciaglia's
	message of "Sun\, 21 Jan 2007 16\:51\:12 +0100")
Message-ID: <m2lkj8tdn2.fsf@dreaming.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Polgen is a collection of scripts and tools developed by the MITRE
corporation to automate the SELinux policy generation process.  You
can download the latest release from <http://polgen.sourceforge.net/>.

This release incorporates two major changes to polgen. First, polgen
now supports generation of reference policy.  Second, polgen uses
Polgen Specification Language (PSL) files to bootstrap analysis.

Polgen handles the modularity of reference policy by searching through
.if files to find interfaces that will handle access requirements of
the program under analysis.  The technique used appears complementary
to Karl MacMillan's Madison library.  There are several polgen user
interface changes that we have made in support of generating
reference policy.  The menu-style interface asks users to fill in
information about known capabilities of program entry points and about
expectations for how the program module might be used by other
to-be-written modules.

PSL allows users to declare those directories and program entry points
that will need to be given special types. For example if configuration
files are used, the psl writer will indicate that a program component
reads from a particular directory and/or reads specific files. PSL can
also be used in a mode where program developers know the behavior of
the program and can offer advice that will statically complement
polgen's dynamic analysis strategy.


--
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
