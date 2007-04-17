Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HHAk3D015827
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:10:46 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HHAhW2019211
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 17:10:43 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l3HH6cBr007397
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:06:38 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l3HH6ckw007396
	for selinux@tycho.nsa.gov; Tue, 17 Apr 2007 13:06:38 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HH0Ipr015090
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:00:19 -0400
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HH0DW2016670
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 17:00:16 GMT
Received: from [127.0.0.1] (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by www346.sakura.ne.jp (8.12.11/8.12.11) with ESMTP id l3HH0B4Y027388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 02:00:11 +0900 (JST)
	(envelope-from kaigai@kaigai.gr.jp)
Message-ID: <4624FD88.9020100@kaigai.gr.jp>
Date: Wed, 18 Apr 2007 02:02:00 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [HACKERS] [RFC] PostgreSQL Access Control Extension (PGACE)
References: <462395ED.7010602@kaigai.gr.jp>
In-Reply-To: <462395ED.7010602@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I started a discussion with PostgreSQL people.

http://archives.postgresql.org/pgsql-hackers/2007-04/msg00664.php

Maybe, most of SELinux people does not subscribe the pgsql-hackers list.
Please tell me, if you want to add Cc: on the thread.
(But you have to subscribe the list to post.)

Thanks,

KaiGai Kohei wrote:
> As I announced alpha version of SE-PostgreSQL about one month ago,
> I'm working for development of a security facility integrated with
> secure operating system.
> 
> It provides database users fine grained mandatory access control
> including row and column level one, and integration with operating
> system security policy.
> 
> This concept may have applicability to other secure operating system
> such as Trusted Solaris. Just after the announcement, Sun.com's people
> were interested in SE-PostgreSQL works, and contacted me.
> They also want to implement a similar functionality on their operating
> system using Trusted Extension (TX).
> 
> We got an agreement that a common framework like LSM will be useful
> to implement and maintain those secure facilities.
> 
> I want to have a discussion and get feedbacks about this idea from
> PostgreSQL developers.
> 
> ----------
> The framework named PGACE(PostgreSQL Access Control Extension).
> It provides two major facilities. One is hooks on some strategic points.
> The other is a functionality to associate a tuple with its security
> attribute.
> 
> Any hooks is defined as a static inline functions in "security/pgace.h".
> They give no effect, if no security facilities are configured.
> If SELinux support is enabled via configure script, those definitions
> are overwritten by "security/sepgsql.h", and the hooks calls actual
> SE-PostgreSQL implementation to provide MAC(mandatory access control).
> 
> Those hooks are deployed on the some strategic points of PostgreSQL such as
> simple_heap_insert(), PortalStart() and so on.
> 
> You can get all the definition of pgace.h and sepgsql.h from the following URL:
>   http://sepgsql.googlecode.com/svn/trunk/src/include/security/
> 
> The later functionality enables to associate a tuple with security attribute.
> It adds a new field (t_security) with Oid type into HeapTupleHeaderData
> structure. The t_security can persistently hold a Oid of pg_security new
> system catalog. The pg_security has a combination of Oid value and security
> attribute with text representation.
> 
> Database users can refer the attribute via new system column.
> When SQL query tries to refer this attribute via the system column,
> PGACE lookups pg_security system column to get a tuple which has same oid
> compared to t_security value of its HeapTupleHeaderData.
> It's implemented as input/output handler of new security_label type.
> 
> The name of system column is defined in pg_config.h.in.
> In SELinux case, it's named "security_context". This system column is
> writable via UPDATE or INSERT statement, to enables relabeling.
> 
> Because most of security attribute shares same text representation, this
> implementation works effectively and economically.
> 
> As you know, PostgreSQL handles any database object as a tuple stored in
> system catalogs. So, this concept may have applicability to any kind of
> database object like table, column and procedure.
> ----------
> 
> I hope that SE-PostgreSQL and PGACE are merged into future upstreamed
> PostgreSQL and we can turn on/off by configure option without any patch.
> 
> I believe any comments and feedbacks are so helpful to indicate the
> direction of our development with an approach which is acceptable by
> PostgreSQL development community.
> 
> Thanks,
> 
> * Reference
> The full set of patch is a bit large to post the list directly. (6.7KL)
> 
> You can checkout the source code from the following URL:
>   http://code.google.com/p/sepgsql/source
> You can get the patch for SE-PostgreSQL based on PGACE from the following URL:
>   http://sepgsql.googlecode.com/files/sepostgresql-8.2.3-226.patch
>   (against to the stable postgresql-8.2.3)


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
