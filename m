Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7JLs7E0029466
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 17:54:07 -0400
Received: from smtp107.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7JLrYKT001711
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 21:53:34 GMT
Message-ID: <4A8C7477.4010807@schaufler-ca.com>
Date: Wed, 19 Aug 2009 14:53:59 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul McNabb <mcnabb@argus-systems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Not quite MLS.
References: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu> <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil> <1250545104.3588.149.camel@rxm-581b.stl.gtri.gatech.edu> <4A89F878.1040604@sun.com> <4A8AD3A1.30109@argus-systems.com>
In-Reply-To: <4A8AD3A1.30109@argus-systems.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul McNabb wrote:
> Glenn is right that the Mitre LEF can only work on a per-system rather
> than a per-user basis for disallowing certain classification and
> compartment/category constraints.  The only MLS system that I know of
> that did what you are asking for is the old Addamax B1st system.  That
> MLS system had user clearances as a set of labels and label ranges
> that allowed a specific user clearance to be something like:
>
> { unc - ts:1,2,3; unc:4 - sec:4 ; con:5 }

Trusted Irix also allows ( allowed? :-( ) a list of ranges of labels.
Trix uses something like:

    user:label1:label1 label2 label3...label127 label200 label300...label400

to say that user would get label1 if he didn't specify a login label
and that he could ask for label1, label2, label200, any label that
dominated label3 that was also dominated by label127 or any label that
was dominated by label300 that was also dominated by label400.

The internal structure of Trix labels is sufficiently complicated that
no one ever spelled them out, they always used aliases.
>
> which would allow the user to be cleared from unc to ts in categories
> 1, 2, and 3 but have only a unc to sec clearance in category 4 and
> only con for category 5.
>
> Strictly speaking, a system can be "fully MLS" regardless of the
> clearance functionality.  Some MLS systems have been built (and
> bought) without any notion of a user clearance at all, particularly
> some MLS systems built to the first generation of TCSEC requirements.

The Trix kernel never had a notion of clearance. All clearance
processing was done in user space. Trix did get a B1 and an LSPP.
Sold pretty well, too. Never did use the Mitre/DIA encodings, either.
At first Mitre wouldn't let us have it, then we figured out we could
live better without it. Not having it may have cost a deal or two,
but we certainly made up for it with simpler interfaces.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
