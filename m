Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96G4CEN030662
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 12:04:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96G2w4o010384
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:02:59 GMT
Subject: Labeled Networking For LSPP: Where we are and where we need to go
	(quickly)
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Cc: paul.moore@hp.com, vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Content-Type: text/plain
Date: Fri, 06 Oct 2006 12:05:38 -0400
Message-Id: <1160150738.10614.116.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last night I built a new test kernel for labeled networking in RHEL5
kernels.  That kernel can be found at 

http://people.redhat.com/sgrubb/files/lspp

and you want the lspp kernel 51.

What's in this kernel?  A whole bunch of patches which might just make
it into RHEL5.  I have until this Monday, Oct 9 to try again.  That
means that I really really need everything finished very quickly (aka
today) so we can get some basic testing!  ALL testing needs to be done
with compat_net = 0 and hopefully in enforcing.  We don't have a good
policy for this yet, but i'll mention that again later.  In this last
kernel we have

-netlabel config auditing patch
-netlabel cache opps patch
-netlabel unlabeled patch
-secid reconciliation between secmark and xfrm
-network_t addition
-secid reconciliation with netlabel
-1/3 of the complete fix for the ipsec information escape

This is great, we are getting there.  But, we still need at least 3-4
more patches before tomorrow!!

Patch1: finish the error propagation backport for the ipsec leak (Being
completed by Eric Paris)
Patch2: audit ipsec config changes (Being completed by Joy Latten)
Patch3: find and fix current issues with unlabeled_t packets that can't
be explained (Paul Moore and Venkat)

There also is some question from Joshua Brindle if the object classes
are correct for a number of things.  These changes also will need to be
done quickly.  I'm going to call this Patch4.

Patch4: verify/fix the object class for all netlabel hooks.  (Hopefully
Venkat will be able to take the lead on this)

It does seem reasonable to think that I will get all 4 of these patches
by the end of the day.  I really really need that to happen.  If so we
stand a good chance of getting all of this into RHEL5 and having working
labeled networking for LSPP!

After these kernel patches go in we still have more work to do!

Policy!  Christopher J. PeBenito has a refpolicy branch with little
other than flow_in and flow_out defined at:

svn co http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029 refpolicy

I don't think the new constraints are in there as they will cause other
problems.  Hopefully the constraint issue will pan out in the next day
or 2.  You can expect lots of denials, but at least enough will be
defined that you can get stuff working in enforcing with your own policy
modules.

When all is said and done we then have a little bit of kernel cleanup
but it won't be for RHEL5.  It will just be upstream code cleanup.
Namely 

1) Patch 7/9 from the reconciliation thread should be cleaned up to
better use BUG_ON()
2) Patch 2/9 should drop polsec from the hook interface in security_ops

I only mention those so they won't be forgotten.

********

If your name was mentioned in one of the 4 patches that I want today can
you please reply and let me know if you think it is possible?  (by
"today" I really mean "before about 9AM saturday morning")  Once again
we are coming up on a tight deadline.  Everyone has done so much to get
us this close and it looks like Red Hat management is giving me again
until this Monday.  But I sure wouldn't expect another extension like
this again!!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
