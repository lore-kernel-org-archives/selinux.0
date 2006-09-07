Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87H7CEi020159
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 13:07:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87H6PuU021192
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:06:26 GMT
Subject: Re: semanage user
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060906161959.GA29623@sergelap.austin.ibm.com>
References: <20060906161959.GA29623@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:07:07 -0400
Message-Id: <1157648827.20616.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-06 at 11:19 -0500, Serge E. Hallyn wrote:
> Hi,
> 
> It appears removing a user with semanage does not also remove it's
> associated logins.  This is a problem because then re-adding the
> user fails.  (I do not have the error handy as my test machines are all
> down atm)
> 
> I had done:
> 	semanage user -a -R abat_r -P abat abat_u
> 	semanage login -a -s abat_u abat
> 	semanage user -r abat_u   [ or is it -d? ]
> 	semanage user -a -R abat_r -P abat abat_u
> 
> the last step failed.  When I then did
> 
> 	semanage login -d abat  (or was it -r?  :)
> 	semanage user -a -R abat_r -P abat abat_u
> 
> it succeeded.
> 
> Not sure whether there is a good reason to leave the code like
> that, or whether semanage user -r should automatically imply
> semanage login -r.
> 

Please create a bug on the newly working upstream bug tracker -
http://sourceforge.net/projects/selinux. You can assign it to me if you
want.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
