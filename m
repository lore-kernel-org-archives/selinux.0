Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PLCnom002304
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 17:12:49 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PLCmRe003815
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 21:12:48 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1734932rvb
        for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 14:12:47 -0700 (PDT)
Message-ID: <7e0fb38c0709251412v4977b455ta5c790d60db89b76@mail.gmail.com>
Date: Tue, 25 Sep 2007 17:12:47 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [RFC PATCH 1/2] [SELINUX] Add a functionality version number
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070925204825.13699.85412.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
	 <20070925204825.13699.85412.stgit@flek.americas.hpqcorp.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/25/07, Paul Moore <paul.moore@hp.com> wrote:
> Add a functionality/compatability version number to the policy so that the
> kernel can query the policy to see what level of functionality it supports.
> ---
>
>  security/selinux/include/security.h |   21 +++++++++++++++++++++
>  security/selinux/selinuxfs.c        |   18 ++++++++++++++++++
>  security/selinux/ss/policydb.c      |   20 ++++++++++++++++++++
>  security/selinux/ss/policydb.h      |    6 +++++-
>  security/selinux/ss/services.c      |    2 ++
>  5 files changed, 66 insertions(+), 1 deletions(-)

Why is this better/different than just using the policy version we
already have in a slightly different way?  We are at version what?
.21?  We already have some compat stuff in context_struct_compute_av()
based on this....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
