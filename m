Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15HfHTh006842
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 12:41:17 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m15HfFts012393
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 17:41:16 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id m15HfFaY007444
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 12:41:15 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to contribute: policy?
Date: Tue, 5 Feb 2008 12:41:13 -0500
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8BC096A@HAVOC.tcs-sec.com>
From: "Scott Lowrey" <slowrey@TrustedCS.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Behalf Of Christopher J. PeBenito
> Sent: Tuesday, February 05, 2008 8:10 AM
> 
> On Mon, 2008-02-04 at 20:08 +0000, Eoin Ryan wrote:
> > I'm on a mission to run a personal server using the strict policy,
> > mainly as a learning exercise.  I've just come across what seems to
be
> > an error in the policy, so I thought a good way to contribute might
be
> > to submit bug reports as I work to configure the system for
> > mail/web/etc.  Is this the correct place/way to submit such
problems?
> 
> You can post it here, but since its RHEL you probably should post it
to
> Red Hat bugzilla so it can go through the right processes to be
included
> in the next RHEL update.
> 

Hello.  I have a similar question, then.  I resolved a small policy
problem related to the IPsec 'setkey' command on the RHEL5 LSPP
platform.  The ipsec setkey command was not allowed to write to stdout.
This problem occurs when newrole is used to get sysadm_r before running
setkey.  

Not sure if it's worth posting but it should be included in downstream
releases.  Should I post a bug at Red Hat along with the fix?  Is there
any need to post the patch here?

--
Scott Lowrey
Trusted Computer Solutions
Herndon, VA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
