Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0VBNM0Q011174
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 06:23:22 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0VBNL3A015932
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 11:23:21 GMT
Message-ID: <4D469BA4.8@itechfrontiers.com>
Date: Mon, 31 Jan 2011 06:23:16 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: Tiny version of SE-PostgreSQL got merged
References: <4D466F3B.6090906@ak.jp.nec.com> <0B31D28E10F4FA489A0261135B94A14804A456B3@XMB-AMS-109.cisco.com>
In-Reply-To: <0B31D28E10F4FA489A0261135B94A14804A456B3@XMB-AMS-109.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Ger.

I actually asked this before from Mr. Kohei, and we had a hot debate 
here I refer you to this archive:

http://marc.info/?l=selinux&m=129178180819602&w=2

Also this is original proposal of the project from Mr. KaiGai Kohei

http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf

In brief:

Since it is possible to use file labels and database locations and have 
multiple instances of Postgresql as it is process based daemon, and just 
separate classified and unclassified databases from each other

BUT:

the goal of Mr. KaiGai Kohei and se-postgresql project is to introduce 
MLS  (Multilevel Security) to the structure of the database and its ACL 
model for each user of the database in example up to the rows and 
columns, so in practice THEORETICALLY it would be possible to mix 
classified or unclassified records within a single database and have 
various levels of users with different levels of access
(however in practice it may not be recommended)

Currently with PostgreSQL it is possible to achieve this by separation 
of databases and their storage location; you have to completely separate 
the datases, processes and daemons accessing such resources up to 
different classifications you want to serve records on an MLS systems.



Best,

Patrick K.





On 1/31/2011 5:09 AM, Ger Lawlor (gelawlor) wrote:
> I'm only new to SeLinux, but will have requirements around PostgreSQL.
> Can you give me some background and info on why
> This SE-PostgresQL exists? Is it specific to this database, or are there
> similar projects for other database types?
> Was it not possible to label files within a default installation? Was
> this insufficient for Postgres security?
>
> Thanks,
> Ger.
>
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of KaiGai Kohei
> Sent: Monday, January 31, 2011 8:14 AM
> To: selinux@tycho.nsa.gov
> Subject: Tiny version of SE-PostgreSQL got merged
>
> A few days ago, a tiny initial version of SE-PostgreSQL got merged
> in the v9.1 development cycle at this commit: http://bit.ly/gF2QPQ
>
> Although it omits various features which I planned at first, it
> seems to me an ambitious first step.
> PostgreSQL has shifted to provide a set of facilities to implement
> label based mandatory access control, such as security label support
> on database objects or security hooks being available for plug-in
> modules.
>
> The current version of SE-PostgreSQL is implemented as a plugin
> module that utilizes these hooks (but only a limited places are
> covered), then it asks SELinux in kernel whether the required
> access shall be allowed, or not.
>
> In the next development, I'd like to expand its access control coverage
> using more fine grained security hooks. Right now, DDL permissions are
> restrictions. Also, row-level security is in-progress feature.
>
> I have much things to do for the v9.2 or v9.3, however, I'd like to
> appreciate people who have given me many feedbacks since 2006
>
> Thanks,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
