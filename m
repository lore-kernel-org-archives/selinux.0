Message-Id: <200507072042.j67KgqQ4013262@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <sds@tycho.nsa.gov>,
   <selinux@tycho.nsa.gov>
Subject: RE: Useradd patchset - seeking comments..
Date: Thu, 7 Jul 2005 16:42:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1120768031.6275.13.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Thursday, July 07, 2005 4:27 PM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; sds@tycho.nsa.gov; selinux@tycho.nsa.gov
> Subject: RE: Useradd patchset - seeking comments..
> 
> 
> > Long term maintenance is everyone's concern
> 
> Which is why this patch should be merged for clarity.
> 
> > Also, I don't like the style - I think that people
> > start worrying about the keyword even though it is useless. Verbosity is
> only
> > useful if it communicates something not already stated.
> 
> It communicates the storage class of the function, which I believe
> is not explicitly stated anywhere. It only stated implicitly, and
> programmers such as myself get confused by the lack of keyword -
> there's several storage classes to choose from, and this makes it clear.
> It also allows you to grep the file for extern, which you may
> want to do for some reason.
> 

There are only 3 options for libraries that I am aware of: static, non-exported,
and exported. Having non-exported prototypes in public headers is, to me, very
confusing. Most of the confusion about what is exported / not exported in
libsepol comes from the fact that it was the bulk of checkpolicy before it
became a library. Ideally the confusion would be fixed by other means.

> You can disagree, but /usr/include/* speaks for itself -
> the vast majority of headers are explicitly marked extern,
> which establishes the dominant style.
> 

Maybe . . .

> ===============
> 
> Also, we should move all headers describing functions
> not exported by the shared library into a subfolder...

Agreed - though that would only support my argument. Anyway - I've stated my
opinion and won't argue about this anymore. It is not important enough and Steve
will do what he wants anyway :)

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
