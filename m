Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6G8OUHa021863
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 04:24:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6G8NSnJ014714
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 08:23:28 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6G8NQhr014707
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 08:23:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: first pass at a spamassassin/spamc/spamd policy
Date: Wed, 16 Jul 2003 18:24:18 +1000
Cc: selinux@tycho.nsa.gov
References: <1058295391.15102.97.camel@columbia> <200307161110.23222.russell@coker.com.au> <1058342362.22214.47.camel@columbia>
In-Reply-To: <1058342362.22214.47.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307161824.18227.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Jul 2003 17:59, Colin Walters wrote:
> > tmp_domain(spamd)
> > allow spamd_t tmp_t:dir { getattr read };
> > The second line should not be needed, the first line should do it.
>
> Ok, hm...I think it wasn't working for me before, but it appears to be
> now; perhaps I picked up a fix in a merge with your tree.

You probably added the second line first, and then added the tmp_domain() 
entry later.  I've done that a few times myself.

> > file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t)
> > create_dir_file($1, $2_home_spamassassin_t)
> >
> > The first line does everything that the second line does.  Also consider
> > whether you need the full capabilities of the file_type_auto_trans()
> > macro, does spamassasin really need to create sockets under the user home
> > directory? Maybe the following will do:
> > file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t, file)
>
> I don't think that's enough, because I want it to be able to create the
> ~/.spamassassin directory too.

I've been thinking of writing a macro that would just allow creation of a 
directory or a file under a particular directory with a type change.

Wanting to create a directory or a file is a really common operation so it 
makes sense for it to be easy to allow it without allowing other things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
