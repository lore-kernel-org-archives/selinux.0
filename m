Message-ID: <484FE7C3.6050701@manicmethod.com>
Date: Wed, 11 Jun 2008 10:57:07 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Dave Quigley <dpquigl@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, bwhalen@tresys.com
Subject: Re: [RFC] Context ordering based on MLS dominance.
References: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dave Quigley wrote:
> This patch set was original made to help in providing unioned polyinstantiated
> directories for MLS. The method used Unionfs to order the branches from the
> highest to lowest levels so when a process at a certain level listed the
> directory contents it would see all of the polyinstantiated directories as one
> with duplicates exposing the document at the highest level found.
> 
> Others have expressed a need for this functionality so the patches have been
> revived. The question is should this be done as a kernel interface or should
> it be done on the on disk policy file using libsepol?

So is this the real functionality people have a need for? My use was to take some set of contexts and order them based on dominance. This patch can be used to do that but at a possibly high cost. Is the standard use case to order some number of contexts or just 2? Is it possible to allow an arbitrary number of contexts to be passed into the kernel interface to be sorted in-kernel or would that be inappropriate?

> 
> The kernel patch is based off of Linus' current git tree as of 6/10 while the
> libselinux patch is based off of the current svn tree from sourceforge as of
> the same date. The patches went through testing initially when I was working
> on polyinstantiated directories but I haven't tested the new version so give
> them a try and see if they meet your needs.
> 
> Dave
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
