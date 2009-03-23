Subject: Re: The status of SE-PostgreSQL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
In-Reply-To: <49C7667A.3020804@ak.jp.nec.com>
References: <49C7667A.3020804@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 23 Mar 2009 11:25:39 -0400
Message-Id: <1237821939.8667.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-03-23 at 19:37 +0900, KaiGai Kohei wrote:
> Here is a bad news.
> 
> I've had a discussion in pgsql-hackers list for a long time, but
> we cannot get a conclusion that SE-PostgreSQL should be merged
> in the PostgreSQL v8.4 which is the next major release, and it
> was postponed to the v8.5 development cycle due to lack of time
> for enough reviewing the feature.
> 
> If it can be released on schedule, the v8.4 is released on the
> second quarter of 2009, and the v8.5 will be relased on a year
> later (but it tend to delay a few months).
> So, it is necessary to apply SE-PostgreSQL patches or install
> it from RPM package distributed via Fedora project. :(
> 
> Under the discussion, I got a few suggestions in its security
> design, and it seems to me fair enough. Some of them needs to
> change definitions in the default policy.
> 
> See the following items,
> 
> * new permission: db_database:{superuser}
> 
> They required a new permission to control database superuser
> privileges similar to "root" capability in operating system.
> The concept of superuser is common for some of major DBMSs,
> not only PostgreSQL. In addition, it seems to me well symmetric
> with operating system.
> 
> The db_database:{superuser} controls whether the client can
> perform as database superuser on the given database, or not.

Any chance of splitting this up into finer-grained privileges?
And what precisely are the implications of this permission:  does it
effectively make all of the other permission checks irrelevant for the
subject?  In comparison, the SELinux capability permissions only allow
the subject to override e.g. DAC file checks, not the SELinux MAC file
checks.

> 
> * undesired permission: db_database:{set_param get_param}
> 
> They wondered the necessity of these checks, because SQL spec
> does not require checks in set/get database parameters.
> I didn't think it is necessary the security design of SELinux
> should be symmetric with SQL, but I also thought these might
> be unnecessary due to another reason.
> In PostgreSQL, the scope of database parameters are session
> local and initialized on the connection startup, so we cannot
> use it as a pass to communicate between different two or more
> domains.

Are any of the database parameters security-relevant (not just
information flow)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
