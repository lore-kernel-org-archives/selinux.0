Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88305O6001934
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 23:00:05 -0400
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k882xe7M018154
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 02:59:41 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k88304O4008759
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 23:00:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k88304qi296778
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 23:00:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k883030G019118
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 23:00:04 -0400
Date: Thu, 7 Sep 2006 22:00:03 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: semanage user
Message-ID: <20060908030003.GA3086@sergelap.austin.ibm.com>
References: <20060906161959.GA29623@sergelap.austin.ibm.com> <1157648827.20616.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157648827.20616.1.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Karl MacMillan (kmacmillan@mentalrootkit.com):
> On Wed, 2006-09-06 at 11:19 -0500, Serge E. Hallyn wrote:
> > Hi,
> > 
> > It appears removing a user with semanage does not also remove it's
> > associated logins.  This is a problem because then re-adding the
> > user fails.  (I do not have the error handy as my test machines are all
> > down atm)
> > 
> > I had done:
> > 	semanage user -a -R abat_r -P abat abat_u
> > 	semanage login -a -s abat_u abat
> > 	semanage user -r abat_u   [ or is it -d? ]
> > 	semanage user -a -R abat_r -P abat abat_u
> > 
> > the last step failed.  When I then did
> > 
> > 	semanage login -d abat  (or was it -r?  :)
> > 	semanage user -a -R abat_r -P abat abat_u
> > 
> > it succeeded.
> > 
> > Not sure whether there is a good reason to leave the code like
> > that, or whether semanage user -r should automatically imply
> > semanage login -r.
> > 
> 
> Please create a bug on the newly working upstream bug tracker -
> http://sourceforge.net/projects/selinux. You can assign it to me if you
> want.

Thanks, done.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
