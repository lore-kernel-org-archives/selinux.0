Message-ID: <4B1864FD.9070207@ak.jp.nec.com>
Date: Fri, 04 Dec 2009 10:25:17 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux ML <selinux@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Josh Berkus <josh@agliodbs.com>, Bruce Momjian <bruce@momjian.us>
Subject: Re: [HACKERS] Adding support for SE-Linux security
References: <200912021616.nB2GGOP24071@momjian.us> <4B16B7BA.3000408@agliodbs.com> <21836.1259786236@sss.pgh.pa.us> <4B183A66.8020002@agliodbs.com>
In-Reply-To: <4B183A66.8020002@agliodbs.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Now I've been suggesting a feature to support SELinux in PostgreSQL again.

Currently, they are in the development cycle for the next release (v8.5)
called "commit fest" that is a similar concept to "merge window" in Linux.
It is a chance to upstream any new features, except for bug fixes.

After the loooong discussion, most of them seems agreed to make progress
to review for inclusion of the feature as a directionality.
However, there are technical gaps. PgSQL hackers are conversant with
PostgreSQL, but not for SELinux.

So, Josh Berkus (the PgSQL core team lead) suggested me to involve SELinux
folks to review the patch, to fill in the gaps.
I'll be happy, if I can see you to help reviewing the SE-PgSQL/Lite patch.
If you are available, please subscribe the pgsql-hackers ML from:
  http://archives.postgresql.org/pgsql-hackers/

Bruce Momjian (the PgSQL core team) summalized the current discussion state.
It is not so bad, compared to two years ago:
  http://archives.postgresql.org/message-id/200912032146.nB3LkNF29978@momjian.us
  http://archives.postgresql.org/message-id/200912021616.nB2GGOP24071@momjian.us

Especially, it seems to me they worry about APIs (libselinux) and differences
in security models. For example, what is the purpose of getpeercon(), why
it needs a security context, why we cannot put security hooks within DAC
routines and so on.
These may be common knowledges in SELinux community, but not in PgSQL.
They want SELinux community to provide development resources more than I
to merge SELinux support, when we need to pay hard efforts.

BTW, the current proposition is titled as "SE-PgSQL/Lite", because I separated
a lot of features from the original design of SE-PostgreSQL to reduce burdens
of reviewers in this stage.
Due to the historic background, I had been repeatedly pointed out to keep
the patch size smaller and step-by-step enhancement.

It might be complaints for SELinux community, however, a limited support
is much better than nothing. I'd like to understand the historic background
in the three year's development.

So, the current proposition focuses on very restricted functionalities to
keep the patch size small, as follows:

* No access controls except for databases, schemas, tables and columns
  PgSQL has various kind of database objects except for the four.
  But it needs to deploy various kind of security hooks in the core routine
  at once, and makes hard to review, if we try to add comprehensive support
  in the first stage. So, I separated access controls on other database
  objects, such as procedures, largeobjects, and so on.

  It is an acceptable compromise. For example, TOMOYO Linux team decided to
  focus on access controls on filesystem at first without their networking
  support, then it got successed. A journey of a thousand miles begins with
  a single step.

* No userspace access vectore cache
  It is a tradeoff between performance and possibility of acceptance.
  In my experience, it needs additional 1KL of changeset for the patch,
  so it makes the hurdle higher instead of the performance in this stage.

  We can anytime add the AVC feature later transparently for users, so
  this patch always calls security_compute_av() as the most simple way.
  Note that AVC in libselinux is not an option for us, because it makes
  a netlink socket for each database connections, but it is not suitable
  for multi-processing (not multi-thread) servers, such as PostgreSQL.

* No row-level granularity in access controls
  Currently, PgSQL does not have row-level granularity support in access
  controls, so we need to develop both of facilities to handle row-level
  granularity and to make access control decision based on SELinux in same
  time.
  However, it is obviously unreasonable from the perspective of changeset
  scales. So, I plans to propose a feature something like Oracle Virtual
  Private Database in the v8.6 development cycle, then add a decision making
  function based on SELinux policy.

* No security identifier support within
  PgSQL stores metadata of the database objects within special tables
  called system catalogs. All the managed four database objects (see above)
  have its own system catalogs.
  The current patch stores a security context of the managed database objects
  as a plain text format in tuples of the system catalogs, because a limited
  number of database objects can have its own label in this version, so no
  need to provide generic framework more than necessity.
  In the original design, I inject a security identifier, indicating a text
  representation of security context on the other system table, within data
  structure of each database rows. However, it also needs additional 1KL of
  changeset in the patch.

Also see the developer documentation:
  http://code.google.com/p/sepgsql/source/browse/trunk/sepgsql/src/backend/security/sepgsql/README

It describes what permissions are defined and implemented in this version.
It helps to avoid confusion come from differences between the current
proposition and the original design.

Thanks,

Josh Berkus wrote:
>> In words of one syllable: I do not care at all whether the NSA would use
>> Postgres, if they're not willing to come and help us build it. 
> 
> There's several 2-syllable words there.  ;-)
> 
>  If we
>> tried to build it without their input, we'd probably not produce what
>> they want anyway.
> 
> Yeah, the *complete* lack of input/help from the security community
> aside from the occasional "SE Linux good" posts we've gotten is
> troubling.  We could end up with a SQL-J.
> 
> Kaigai, you've said that you could get SELinux folks involved in the
> patch review.  I think it's past time that they were; please solicit them.
> 
> --Josh Berkus
> 
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
