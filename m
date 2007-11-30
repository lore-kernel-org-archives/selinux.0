Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUIK2H2026071
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 13:20:02 -0500
Received: from g1t0026.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUIK07Y004843
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 18:20:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Todd Miller" <Tmiller@tresys.com>
Subject: Re: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 13:19:55 -0500
Cc: "Joshua Brindle" <method@manicmethod.com>, selinux@tycho.nsa.gov
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com> <200711301130.27524.paul.moore@hp.com> <6FE441CD9F0C0C479F2D88F959B0158801455A30@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801455A30@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711301319.55735.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 11:59:54 am Todd Miller wrote:
> Paul Moore wrote:
> > On Friday 30 November 2007 9:43:29 am Joshua Brindle wrote:
> >> Aside from this issue have you tried the patch against your kernel
> >> patches? We did not test with your kernel, we inspected the policy
> >> manually to ensure the ebitmap was set up correctly.
> >
> > Help?  What is this patch backed against?
>
> They are based on selinux trunk.  You do not want Josh's original diffs
> applied as the new diffs are meant to supercede Josh's.  I just svn up'd
> to rev 2692 and verified that they still apply.

Okay, that's what I thought but when I tried applying just your patch it 
wouldn't apply so I tried applying Josh's patches first.

> > I have a fresh copy of the SVN sources and I get a ton of failures
> > applying just this patch.  If I go back and apply Josh's original two
> > patches then try applying Todd's patch I still get failures, although
> > there are less of them.
>
> I don't know why that would be.  I have verified that the patch that
> arrived via the list didn't get munged in transit.

Okay, well maybe I'm doing something stupid but the patch appears to modify 
two files which do not exist in my SVN tree ...

 * trunk/libsepol/include/sepol/policydb/polcaps.h
 * trunk/libsepol/src/polcaps.c

The rest of the patch appears to apply just fine.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
