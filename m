Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IIngTC014417
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 13:49:42 -0500
Received: from e4.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0IIoaih026369
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 18:50:37 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0IIoVCe013477
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 13:50:31 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0IIoVCb268092
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 13:50:31 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0IIoVx7012887
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 13:50:31 -0500
Date: Thu, 18 Jan 2007 12:50:30 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
Message-ID: <20070118185030.GB10975@sergelap.austin.ibm.com>
References: <45AFA5F5.2080908@redhat.com> <681036.75164.qm@web36611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <681036.75164.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> 
> --- Karl MacMillan <kmacmill@redhat.com> wrote:
> 
> > > There are others who would argue that SELinux
> > > has abandoned the Linux privilege model and
> > > thus disrupted the unity of the existing
> > > security model.
> > >
> >
> > No clue what this means.
> 
> Pre-SE Linux has a rational and well
> established security model that includes
> DAC and Privilege. The capability scheme
> is designed to fit that model, adding the
> logical extention from the POSIX statements
> of "appropruate privilege" to defining what
> those privileges would be.
> 
> SELinux does not use capabilities to identify
> where "policy" is excepted, rather it defines
> policy in such a way as to make the notion of
> exception unnecessary. Many people think this
> is good. I personally like the traditional
> scheme, and would be happier with SELinux if
> it held to it.
> 
> > > I don't understand why the SELinux crew seems
> > > so intent on making it difficult to implement
> > > alternatives. Last year it was "let's ditch LSM".
> > > Now it's "Everyone hates stacking". Give it a
> > > rest already.
> > >
> >
> > 1) Stacking is possible now, just not arbitrary
> > stacking by an admin.
> 
> True enough, although I have to say that it
> isn't a pleasant exercise.
> 
> > 2) Not having arbitrary stacking in no way limits
> > alternatives. It just
> > forces the use of a single alternative at a time or
> > explicit development
> > to make alternatives work together.
> 
> Funny thing is that I would agree with you 100%
> if LSM implemented authoritative hooks. Since
> LSM implements a scheme that is supposed to
> provide strictly for additional restrictions
> it should be simple to stack modules safely.

An example where that is not the case is if LSM 2 needs to label
a file as 'toptopsecret noone may touch this', but LSM 1 has
marked claimed that the user may not write an xattr.  So now
the user's info can be leaked.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
