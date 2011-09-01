From: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
To: Joshua Brindle <method@manicmethod.com>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: RE: sepgsql and process transition
Date: Thu, 1 Sep 2011 15:51:45 +0000
Message-ID: <D0C1A1F8BF513F469926E6C71461D9EC0523B8@EX10MBX02.EU.NEC.COM>
References: <4E5D2DBA.9060201@manicmethod.com>
 <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com>
 <4E5E933B.6060604@manicmethod.com>
 <CADyhKSVcA2LtxMnVvcAZ5zvWbs8E=RtFrV9bvLYo6ukDpRYc-Q@mail.gmail.com>
 <D0C1A1F8BF513F469926E6C71461D9EC051E85@EX10MBX02.EU.NEC.COM>
 <4E5F9921.6020102@manicmethod.com>
In-Reply-To: <4E5F9921.6020102@manicmethod.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > I think it is not a situation that we should allow staff_t:SystemLow-SystemHigh
> > to translate into sepgsql_trusted_proc_t:SystemHigh, because this rule intends
> > to prevent to switch lower range without special attributes, and it eventually
> > prevents violated references of information.
> > Even if we have individual object class to represent a subject entity of database
> > system, its fundamental is not changed, is it?
> 
> If staff running at system low need to use a trusted procedure to get (and
> redact, remove precision, etc) system high data they must be able to transition
> like that. Even if the user is running at systemlow-systemhigh, since their
> active clearance is systemlow, their user type must have privrangetrans which is
> not desirable.
> 
If we add "db_client" as a new object class for a subject entity of database system,
How does the MLS constraint of db_client control the domain transition?
I guess the rule shall follow the process class:

  mlsconstrain db_client transition
          (( h1 dom h2 ) and
            (( l1 eq l2 ) or ( t1 == mlsprocsetsl ) or
            (( t1 == privrangetrans ) and ( t2 == mlsrangetrans ))));

However, in this case, staff_t still requires privrangetrans and sepgsql_trusted_proc_t
requires mlsrangetrans. If we exceptionally allows to upgrade/downgrade range of subject
entity on database system, unlike operating system, it is arguable...

> >> One other point I'm considering is what security label should be delivered to
> >> when a database client want to invoke a remote procedure call using functions
> >> installed to PostgreSQL. This feature is called 'foreign-data-wrapper' being
> >> already merged at v9.1.
> >> If we assign a subject entity that performs as an agent of client a security
> >> label that is not a part of domain attribute, I'm not certain whether it is an
> >> appropriate manner, or not.
> >>
> > One other confusable situation is invocation of remote procedure from PostgreSQL.
> > If we try to set up multiple SE-PostgreSQL systems that communicate via labeled
> > networking each other, I'm afraid that analysis of domain transition becomes hard
> > because it allows multiple paths to translate other domains.
> >
> 
> The tools will need to be updated to handle the additional transition via db
> procedure but the analysis is no different than a domain transition or
> transitive information flow analysis of today.
> 
It is OK for me at this point.

> > Right now, my opinion is that process:{translate} permission should be checked
> > when a subject entity of (operating|database) system tried to be switched.
> >
> 
> trusted procedures are not processes and should not use the process object class.
> 
We may need to have an upper meta-level viewpoint.

When a subject entity appeared in operating system, we call it "process".
When a subject entity appeared in database system, we call it something like "db_client".
And, a subject entity appeared in operating system tries to access database objects,
its security label is dealt with "db_client" class. Hmm.

Thanks,
--
NEC Europe Ltd, SAP Global Competence Center
KaiGai Kohei <kohei.kaigai@emea.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
