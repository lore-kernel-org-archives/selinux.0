Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HDTmrT009214
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 09:29:48 -0400 (EDT)
Received: from gkgreen.dor.state.ma.us (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HDTkq2009791
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 13:29:46 GMT
Message-Id: <6.1.1.1.0.20040617092449.02d68008@dor-exchange.dor.state.ma.us>
Date: Thu, 17 Jun 2004 09:29:18 -0400
To: selinux@tycho.nsa.gov
From: "bmcmurphy@dor.state.ma.us" <bmcmurphy@dor.state.ma.us>
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yep, that behavior would be just we're looking for. I would think it would 
certainly help to scale selinux to systems with large numbers of users.

Cheers,

B McMurphy



>
>-----Original Message-----
>From: Russell Coker [mailto:russell@coker.com.au]
>Sent: Wednesday, June 16, 2004 11:14 PM
>To: bmcmurphy@dor.state.ma.us
>Cc: selinux@tycho.nsa.gov; Stephen C. Tweedie
>Subject: Re: RBAC with Unix Groups/GUIDs
>
>
>On Thu, 17 Jun 2004 07:54, "bmcmurphy@dor.state.ma.us"
><bmcmurphy@dor.state.ma.us> wrote:
> > I think I know the answer to this, but is there any way in selinux to
> > assign an entire group (GUID) to a selinux role instead of just adding
> > individual users? We are using LDAP-based authentication and I'd like to be
> > able to assign a GUID to a selinux role and be done with it, rather than
> > having to muck with the selinux policy whenever I add a new user into the
> > group. Maybe I'm missing something obvious. Wouldn't be the first time...
>
>The mapping of Unix UID/GID to SE Linux identity is determined by the code in
>the login program, this can be a patched sshd or xdm type program or a PAM
>module called by /bin/login.  The SE Linux identity determines the permitted
>roles.
>
>The code to map UID/GID to SE Linux identity currently tries to assign an
>identity of the Unix user-name, and failing that it uses an identity of
>"user_u" as a generic identity.
>
>It would not be a difficult coding task to change the library code that does
>this to use the group name based on the GID as the SE Linux identity in some
>situations.
>
>We could have an algorithm of:
>1)  Try Unix login name (NB not the result of getpwuid() on the UID) as SE
>Linux identity and use it if it exists.
>2)  Call getgrgid() on the primary GID for the user and try the group name as
>the SE Linux identity and use it if it exists.
>3)  Use user_u if possible, otherwise fail the login.
>
>
>I think that this would solve some problems raised by Steve Tweedie (among
>other people) regarding the use of NIS.
>
>--
><http://www.coker.com.au/selinux/>http://www.coker.com.au/selinux/   My 
>NSA Security Enhanced Linux packages
><http://www.coker.com.au/bonnie++/>http://www.coker.com.au/bonnie++/ 
>Bonnie++ hard drive benchmark
><http://www.coker.com.au/postal/>http://www.coker.com.au/postal/    Postal 
>SMTP/POP benchmark
><http://www.coker.com.au/~russell/>http://www.coker.com.au/~russell/  My 
>home page



**********************************************************************
This email and any files transmitted with it are confidential and 
intended solely for the use of the individual or entity to whom they   
are addressed. If you have received this email in error please notify 
the system manager at postmaster at dor.state.ma.us.
**********************************************************************


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
