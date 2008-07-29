Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TCPSfm007572
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 08:25:28 -0400
Received: from QMTA05.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TCPQXf020289
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 12:25:27 GMT
Date: Tue, 29 Jul 2008 08:25:23 -0400
From: Scott Schmit <i.grok@comcast.net>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] Thread/Child-Domain Assignment
Message-ID: <20080729122523.GA27206@arithon.mars.sol>
References: <487C7698.60503@ak.jp.nec.com> <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil> <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4889CF38.6010301@ak.jp.nec.com> <488EC3A0.5010000@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <488EC3A0.5010000@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 29, 2008 at 04:15:44PM +0900, KaiGai Kohei wrote:
> KaiGai Kohei wrote:
> > [2/3] thread-context-checkpolicy.1.patch
> >   This patch add a new statement of TYPEDOMINATE for policy language.
> > 
> >     TYPEDOMINATE <parent type>  <chile type> [, <child type> ...] ;
> > 
> >   It defines expilct hierarchical relationship between two types.
> >   Existing name based hierarchy is dealt as TYPEDOMINATE is described
> >   implicitly.
> 
> I reconsidered that the statement should be replaced as follows,
> because "DOMINATE" is an associated term with MLS and roles/users
> also have name based hierarchy ideas now.
> 
>   HIERARCHY <parent type> TYPES <child type> [, <child type> ...];
>   HIERARCHY <parent role> ROLES <child role> [, <child role> ...];
>   HIERARCHY <parent user> USERS <child user> [, <child user> ...];
> 

I agree that TYPEDOMINATE is not a good choice. In dominance, you're
saying "whatever privileges x, y, & z have, give me those too."

I like to think of it as the parent type "circumscribing" or limiting
its children -- the parent draws a line in the sand and says "<child>,
you can grant yourself whatever permissions you want (hopefully no more
than you need), but whatever you do, don't cross this line!" The terms
used to should make that obvious. "Circumscribe" is fun to say, but
awkward to type, so how about:

    TYPELIMIT <parent type> { <child type> [, <child type> ...] } ;
    ROLELIMIT <parent role> { <child role> [, <child role> ...] } ;

It would read better to say:

    TYPE <parent type> LIMITS { <child type> [, <child type> ...] } ;
    ROLE <parent role> LIMITS { <child role> [, <child role> ...] } ;

but that conflicts with existing syntax. Hence the patterning after
attributes and aliasing.

I'm not sure what hierarchy for users implies, or why it's needed. If we
have adequate support for hierarchy/dominance in roles, doesn't that
suffice for users? After all, users can't do anything their roles don't
permit them to. I guess I see users as a slightly different case because
they are going to be more per-system than roles or types, so if you
don't trust system administrators to set a user's roles correctly, you
shouldn't make them a sysadmin. Or am I missing something?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
