Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0CJlVFL030074
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 14:47:31 -0500
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0CJmM8g008801
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 19:48:22 GMT
Date: Fri, 12 Jan 2007 11:48:21 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] clarifications for -l to newrole.1
To: Joe Nall <joe@nall.com>, casey@schaufler-ca.com
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <19B0C9A6-C287-4F86-B3B1-BCD3D5025E13@nall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <777669.5095.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Joe Nall <joe@nall.com> wrote:


> On HP-UX 10.26, normal users can login at syslo,
> which in our systems  
> corresponds to unclassified.

Hmm.

> There is no special effort made to use  
> MLS to protect the TCB (some files are syshi because
> of their contents).

Hmm.

> Does Trusted Irix use a distinct level or
> an implicit bit in the non SystemLow labels?

Trix labels are "sophisticated". They include
both sensitivity (MSEN) and integrity (MINT)
components. A sensitivity can be MSEN_LOW
(SystemLow) MSEN_HIGH (SystemHigh), MSEN_ADMIN
(/etc/shadow), MSEN_TCSEC (with levels and
categories), or a couple other special types.
All TCB data is either MSEN_LOW or MSEN_ADMIN.
Users get MSEN_TCSEC labels, which can have
a level 0-255 and a set of categories.
MSEN_TCSEC labels dominate MSEN_LOW.

MINT is also used, with TCB data getting
MINT_HIGH labels and users getting MINT_BIBA.

In retrospect Trix labels are more complicated
than they need to be. I'm looking into a better
way for my "next" system.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
