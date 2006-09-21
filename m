Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LEoE9F013908
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:50:14 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LEnFSR019789
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:49:16 GMT
Subject: Re: Latest diffs
From: Joshua Brindle <jbrindle@tresys.com>
To: "Mikel L. Matthews" <mikel@argus-systems.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45129CD0.5040507@argus-systems.com>
References: <45116881.3060406@redhat.com>
	 <1158846352.3920.33.camel@sgc.columbia.tresys.com>
	 <45129CD0.5040507@argus-systems.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 10:49:32 -0400
Message-Id: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 09:08 -0500, Mikel L. Matthews wrote:
> 
> Christopher J. PeBenito wrote:
> > On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> > 
> > I haven't looked at the patch but I have some initial reactions from
> > your description:
> > 
> >> http://people.redhat.com/dwalsh/SELinux/policy.diff
> >>
> >> Changed to allow 1024 categories.
> > 
> > Why do we need this many?  This isn't even an incremental change up to
> > something like 384 or 512.
> 
> We have customers that use all of our 1024 categories and want more. 
> They have requested 10,000 categories.
> 

That is because they are probably using categories as an integrity
mechanism which is entirely inappropriate for SELinux since TE should be
used for integrity and mls should only be used for confidentiality. I
seriously doubt that a reasonable system could have 10000 useful
categories.

I don't think this change should be made to the refpolicy policy without
a good justification, saying "MLS people want it" isn't good, its
possible that they are also misusing categories.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
