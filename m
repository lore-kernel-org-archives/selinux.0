Subject: RE: PATCH: peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>, Joshua Brindle <method@manicmethod.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801455A30@exchange.columbia.tresys.com>
References: 
	 <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com>
	 <200711300929.22874.paul.moore@hp.com> <47502191.7050300@manicmethod.com>
	 <200711301130.27524.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455A30@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 12:08:32 -0500
Message-Id: <1196442512.10720.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 11:59 -0500, Todd Miller wrote:
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

Nope, doesn't work for me either.    Look - the very first hunk adds
lines to a libsepol/include/sepol/policydb/polcaps.h file, but that
doesn't exist in trunk at all.  Paul is right - it looks to be relative
to Joshua's patches, but not quite a perfect match there either.

> 
> > I have a fresh copy of the SVN sources and I get a ton of failures
> > applying just this patch.  If I go back and apply Josh's original two
> > patches then try applying Todd's patch I still get failures, although
> > there are less of them. 
> 
> I don't know why that would be.  I have verified that the patch that
> arrived via the list didn't get munged in transit.
> 
>  - todd
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
