Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BFs7Ou024276
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 11:54:07 -0400
Received: from smtp109.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5BFs7v8023552
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 15:54:07 GMT
Message-ID: <484FF517.4030400@schaufler-ca.com>
Date: Wed, 11 Jun 2008 08:53:59 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
MIME-Version: 1.0
To: Dave Quigley <dpquigl@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        bwhalen@tresys.com
Subject: Re: [RFC] Context ordering based on MLS dominance.
References: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dave Quigley wrote:
> This patch set was original made to help in providing unioned polyinstantiated
> directories for MLS. The method used Unionfs to order the branches from the
> highest to lowest levels so when a process at a certain level listed the
> directory contents it would see all of the polyinstantiated directories as one
> with duplicates exposing the document at the highest level found.
>
>   

How do you address TS/A and TS/B objects with the same name in
the presence of a TS/A,B subject? In B&L neither is "higher"
than the other, they are incomparable, and the subject should
be able to read both. I suppose you could chose and document
secondary criteria, but I shouldn't think that very satisfactory.


> Others have expressed a need for this functionality so the patches have been
> revived. The question is should this be done as a kernel interface or should
> it be done on the on disk policy file using libsepol?
>
> The kernel patch is based off of Linus' current git tree as of 6/10 while the
> libselinux patch is based off of the current svn tree from sourceforge as of
> the same date. The patches went through testing initially when I was working
> on polyinstantiated directories but I haven't tested the new version so give
> them a try and see if they meet your needs.
>
>   

Whichever way you would do it, I don't think you've
got a general solution to the problem.

> Dave
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>   


-- 

----------------------

Casey Schaufler
casey@schaufler-ca.com
650.906.1780



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
