Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1K9iI8a014701
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 04:44:18 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1K9jWBI005293
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 09:45:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
Date: Tue, 20 Feb 2007 20:45:22 +1100
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
References: <45D542AF.1030108@kaigai.gr.jp> <200702191750.31301.russell@coker.com.au> <45DA5829.7060800@ak.jp.nec.com>
In-Reply-To: <45DA5829.7060800@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200702202045.24263.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 20 February 2007 13:08, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
> > What Unix access controls are applied?  I guess that as PostgreSQL users
> > don't have a direct relationship with Unix users it can't check the UID
> > so it's just a matter of what files the database server has read and
> > execute to which are in that directory.
> >
> > Does it just check to make sure that the file isn't a sym-link and isn't
> > world-writable.
>
> UNIX access controls are applied between the PostgreSQL server process UID
> and shared library files, independent from client process's UID.

Do you mean that it just opens the file and relies on Unix permissions to 
determine whether the open succeeds?

> A sym-link checking is done, but its purpose is to avoid to load a same
> shared library file twice or more.

That's not going to work very well.  Checking st_ino and st_dev is the only 
reliable way of doing it.  But I guess if they are only dealing with mistakes 
and not malicious actions then it's OK (of course it's easier to check two 
integers than multiple sym-links).

> > Other programs might need such triples in the policy, I wonder if it
> > would be possible to make this a generic language feature.  Some sort of
> > policy class which instead of actions takes another type as the third
> > parameter.
>
> I think it should be resolved by macros in the reference policy period.
>
> e.g)
>    sepgsql_enable_load_shlib(db_client_t, sepgsql_t, shlib_t)
>      =>  allow db_client_t sepgsql_db_t : database { load_module };
>          allow sepgsql_db_t shlib_file_t : database { associate };
>          allow db_client_t shlib_file_t : database { load_module };

Yes, that will work.  However there might be benefits in other situations as 
well for extending the policy language...

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
