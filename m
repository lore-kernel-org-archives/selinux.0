Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NN4SrT013832
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 19:04:28 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NN4RUk007171
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 23:04:27 GMT
Date: Fri, 24 Sep 2004 00:15:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "James R. Marcus" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied
Message-ID: <20040923231535.GB8569@lkcl.net>
References: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local> <4153143C.2090405@redhat.com> <200409240622.07118.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409240622.07118.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 24, 2004 at 06:22:07AM +1000, Russell Coker wrote:

> On Fri, 24 Sep 2004 04:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > James R. Marcus wrote:
> > >What is the right way to deal with this issue?  When root logs in should
> > >they automatically be in the sysadm_r role or should these files be
> > >labeled with staff_r?
> >
> > It is working the way it was designed.  In Fedora Core, we changed to
> > use staff_* for the home directory, because
> > we thought it was too confusing for the users.  There is a security risk
> 
> We should revert that change.  It causes too many other issues and does no 
> good.
> 
> Now that the targeted policy is the default most people who don't want to know 
> much about SE Linux will stick with targeted and never encounter this.
> 
> With the strict policy a user who logs in as root:staff_r:staff_t will 
> discover that they can't do most things that they want to do as root and will 
> have to run newrole before doing anything else, so there will be no extra 
> confusion about lack of write access to /root.
 
 ah, but running newrole is not enough: not having write access to
 /root/.bash_profile results in bash not _reading_ the file either.

 result of that is that you lose all your PATH settings and everything
 else you'd expect to be done from bash_profile.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
