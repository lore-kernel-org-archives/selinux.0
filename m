Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26J6ul7013522
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 14:06:56 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26J8Mxq017695
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 19:08:23 GMT
Received: by wx-out-0506.google.com with SMTP id s17so2401409wxc
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2007 11:08:22 -0800 (PST)
Message-ID: <45EDBB95.50703@kaigai.gr.jp>
Date: Wed, 07 Mar 2007 04:05:57 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp> <200703062034.24993.russell@coker.com.au>
In-Reply-To: <200703062034.24993.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> Run the following script to initialize the database cluster:
>>
>>   # /etc/init.d/sepostgresql initdb
>>
>> The database cluster is generated under /var/lib/sepgsql/data .
> 
> Why do you have a different name and different database location?  Why not 
> just call it postgresql and have the same locations and script names?
> 
> When I make such releases I just use a newer package version.

The same package name or the same database location means that users have
to uninstall the native PostgreSQL. I thought that users can avoid conflict
is better.

>> Run the following script to start up SE-PostgreSQL server, after you
>> confirm the native PostgreSQL server is stopping.
>>
>>   # /etc/init.d/sepostgresql start
> 
> Why must you confirm that the native postgresql server is stopped?  Is it a 
> matter of ports and named pipes for communication with clients?  If you can 
> have both packages installed at the same time then some people will want to 
> run them both at once.

The purpose is to avoid conflict of tcp/5432 port in the most simple way.
If you want to use both package at same time, alternative tcp port should be
written at /etc/sysconfig/sepostgresql .

>> * There is no compatibility between SE-PostgreSQL and PostgreSQL.
>>   You have to pay attention not to destroy your database files
>>   for native PostgreSQL.
> 
> Have you considered enabling "permissive mode" for the database server such 
> that it can run with unlabeled databases?
>
> Why can't "native PostgreSQL" just ignore the labelling?

We have to store a security context of tuple in anywhere, so modifying the file
format was not avoidable. The storage manager of PostgreSQL cannot handle different
file formats, so SE-PostgreSQL cannot run over the unlabeled databased generated
by native PostgreSQL.

It might be possible, but I expect more hooks to the PostgreSQL is necessary.
It will prevent to follow the version-up of native one.

Thanks,

> I think it would be good if all the compatibility options that are available 
> for ext2/3 were available for databases.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
