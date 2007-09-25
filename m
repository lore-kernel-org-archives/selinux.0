Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PLHwZ8002741
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 17:17:58 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PLHwRe004569
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 21:17:58 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [RFC PATCH 1/2] [SELINUX] Add a functionality version number
Date: Tue, 25 Sep 2007 17:16:39 -0400
Cc: selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <20070925204825.13699.85412.stgit@flek.americas.hpqcorp.net> <7e0fb38c0709251412v4977b455ta5c790d60db89b76@mail.gmail.com>
In-Reply-To: <7e0fb38c0709251412v4977b455ta5c790d60db89b76@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251716.39502.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 September 2007 5:12:47 pm Eric Paris wrote:
> On 9/25/07, Paul Moore <paul.moore@hp.com> wrote:
> > Add a functionality/compatability version number to the policy so that
> > the kernel can query the policy to see what level of functionality it
> > supports. ---
> >
> >  security/selinux/include/security.h |   21 +++++++++++++++++++++
> >  security/selinux/selinuxfs.c        |   18 ++++++++++++++++++
> >  security/selinux/ss/policydb.c      |   20 ++++++++++++++++++++
> >  security/selinux/ss/policydb.h      |    6 +++++-
> >  security/selinux/ss/services.c      |    2 ++
> >  5 files changed, 66 insertions(+), 1 deletions(-)
>
> Why is this better/different than just using the policy version we
> already have in a slightly different way?

It's different but that's about it ... I did it this way because thought 
people would object to using the policy version for such a purpose.  I'm more 
than happy to use the existing policy version if that is okay.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
