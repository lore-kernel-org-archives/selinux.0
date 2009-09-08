Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n884CSS8018069
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 00:12:28 -0400
Received: from e32.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n884DlD5023763
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 04:13:47 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8847wRn010566
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 22:07:58 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n884CRoC186360
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 22:12:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n884CLdM028187
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 22:12:27 -0600
Date: Mon, 7 Sep 2009 23:12:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [RFC PATCH 2/2] cr: debug security_checkpoint_header and
	security_may_restart
Message-ID: <20090908041221.GB25161@us.ibm.com>
References: <20090903222824.GB27377@us.ibm.com> <20090903222853.GA27556@us.ibm.com> <4AA0A3AE.9040106@schaufler-ca.com> <20090904134611.GA11508@us.ibm.com> <4AA55183.4020407@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA55183.4020407@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> Serge E. Hallyn wrote:
> > Quoting Casey Schaufler (casey@schaufler-ca.com):
> >   
> >> Serge E. Hallyn wrote:
> >>     
> >>> This patch, for debugging only, introduces a silly admin-controlled
> >>> 'policy version' for smack.  By default the version is 1.  An
> >>> admin (with CAP_MAC_ADMIN) can change it by echoing a new value
> >>> into /smack/version.
> >>>   
> >>>       
> >> The scheme you have suggested is just one step off of completely
> >> acceptable for real. More detail below, but if you make the "version"
> >> a string instead of a number I'm happy with it. In particular, a
> >> string that would itself be a valid Smack label makes everything
> >> really simple.
> >>     
> >
> > Presumably at many sites the version will be a unique string not
> > used as a label anywhere else.  That's ok?
> >
> >   
> >> It would take me a few days, but if you're not in a real hurry or
> >> you're lazier than I am (yeah, right) I could provide a patch that
> >> does it. Or, if I haven't been completely incomprehensible, you
> >> could do a revision.
> >>     
> >
> > Heh, I'm in no hurry.  I'll mark this to do midway next week, if
> > you haven't gotten around to it first.  Thanks!
> >   
> 
> 
> I hate to be a bother, but what tree are you basing these patches on?
> Suspect that I missed a round of patches along the way, and can't apply
> the ones I do have.

Sorry, the c/r tree is at:

git://git.ncl.cs.columbia.edu/pub/git/linux-cr.git

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
