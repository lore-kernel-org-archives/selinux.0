Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26AoB3Y022669
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 05:50:11 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26ApYOM025824
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 10:51:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
Date: Tue, 6 Mar 2007 20:34:23 +1100
Cc: selinux@tycho.nsa.gov
References: <45EC0D21.2070706@kaigai.gr.jp>
In-Reply-To: <45EC0D21.2070706@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200703062034.24993.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 March 2007 23:29, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> SE-PostgreSQL 8.2.3-1.0 alpha was released as follows.

Congratulations on making this release, this is great work and a significant 
milestone in SE Linux development!

> Get RPM packages from the following URL:
>   http://code.google.com/p/sepgsql/downloads/list
>     selinux-policy-2.4.6-40.sepgsql.noarch.rpm
>     selinux-policy-targeted-2.4.6-40.sepgsql.noarch.rpm
>     sepostgresql-8.2.3-0.206a.i386.rpm
>
> Run the following script to initialize the database cluster:
>
>   # /etc/init.d/sepostgresql initdb
>
> The database cluster is generated under /var/lib/sepgsql/data .

Why do you have a different name and different database location?  Why not 
just call it postgresql and have the same locations and script names?

When I make such releases I just use a newer package version.

> Run the following script to start up SE-PostgreSQL server, after you
> confirm the native PostgreSQL server is stopping.
>
>   # /etc/init.d/sepostgresql start

Why must you confirm that the native postgresql server is stopped?  Is it a 
matter of ports and named pipes for communication with clients?  If you can 
have both packages installed at the same time then some people will want to 
run them both at once.

> * There is no compatibility between SE-PostgreSQL and PostgreSQL.
>   You have to pay attention not to destroy your database files
>   for native PostgreSQL.

Have you considered enabling "permissive mode" for the database server such 
that it can run with unlabeled databases?

Why can't "native PostgreSQL" just ignore the labelling?

I think it would be good if all the compatibility options that are available 
for ext2/3 were available for databases.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
