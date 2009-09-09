Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89Jl559031546
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:47:05 -0400
Received: from e33.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n89JkOWd016286
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 19:46:24 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n89JiviW027004
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 13:44:57 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n89Jl0Tt248194
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 13:47:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n89Jkx2C009315
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 13:47:00 -0600
Date: Wed, 9 Sep 2009 14:46:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [RFC PATCH 2/2] cr: debug security_checkpoint_header and
	security_may_restart
Message-ID: <20090909194659.GA1065@us.ibm.com>
References: <20090903222824.GB27377@us.ibm.com> <20090903222853.GA27556@us.ibm.com> <4AA0A3AE.9040106@schaufler-ca.com> <20090904134611.GA11508@us.ibm.com> <4AA55183.4020407@schaufler-ca.com> <20090908041221.GB25161@us.ibm.com> <4AA73278.4030301@schaufler-ca.com> <20090909143542.GA23322@us.ibm.com> <4AA7C138.6000205@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA7C138.6000205@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> Serge E. Hallyn wrote:
> > Quoting Casey Schaufler (casey@schaufler-ca.com):
> >   
> >> Serge E. Hallyn wrote:
> >>     
> >>> Quoting Casey Schaufler (casey@schaufler-ca.com):
> >>> Sorry, the c/r tree is at:
> >>>
> >>> git://git.ncl.cs.columbia.edu/pub/git/linux-cr.git
> >>>   
> >>>       
> >> The four patches from 08/28 (2-5) and the two from 09/03
> >> are not happy applying to this tree. Am I missing a patch?
> >>
> >>     
> >
> > There was this patch which was 1/5
> > 	https://lists.linux-foundation.org/pipermail/containers/2009-August/020212.html
> >
> > But there have also been some changes since that posting to the
> > git tree.  You could rewind the git tree to the state it was in
> > on aug 28, but I'll need to forward-port my patches anyway, so
> > let me do that this afternoon and resend the patchset.
> >
> >   
> 
> I figured it was something like that. Thank you.

Actually the patches still apply cleanly.  But it turns out
that when you clone the linux-cr tree, it pulls the ckpt-v17
branch, and only the ckpt-v17 branch.  It is hugely different
from the ckpt-v17-dev tree, which is the one you want.  So
assuming you created a kernel tree by doing git clone
git://git.ncl.cs.columbia.edu/pub/git/linux-cr.git (as opposed
to tweaking your .git/config in another git tree), then you
want to:

	git fetch origin ckpt-v17-dev:ckpt-v17-dev
	git checkout ckpt-v17-dev

The lsm c/r patches should apply cleanly there.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
