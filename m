Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6G804Ha021811
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 04:00:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6G7x3nJ013785
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 07:59:03 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6G7x2hr013782
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 07:59:02 GMT
Subject: Re: first pass at a spamassassin/spamc/spamd policy
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307161110.23222.russell@coker.com.au>
References: <1058295391.15102.97.camel@columbia>
	 <200307161110.23222.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058342362.22214.47.camel@columbia>
Mime-Version: 1.0
Date: 16 Jul 2003 03:59:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-15 at 21:10, Russell Coker wrote:

> I was thinking of a wrapper written in C which is compiled. 

That would make more sense, yeah.

>  Do we even have 
> enough utility programs to allow such things to be written in shell scripts?

I guess I was mainly thinking of "runas", but we might need more than
that.

> When you have the wrapper as discussed you just need the following:
> allow $1_$2_t privfd:fd use;
> allow $1_$2_t { $1_devpts_t $1_tty_device_t }:chr_file rw_file_perms;

Ok, I've done that in my tree.

> Also another possibility is for the wrapper program to change the type of the 
> terminal device in a similar manner to newrole and then change it back after 
> the program is complete.  Then the program can't run amok on terminals from 
> other sessions by the same user.

I dislike this idea; it's OK for newrole because newrole kind of takes
over your terminal with the password prompt and everything.  But it
would be reasonable to run spamassassin and something else
simultaneously.

> tmp_domain(spamd)
> allow spamd_t tmp_t:dir { getattr read };
> The second line should not be needed, the first line should do it.

Ok, hm...I think it wasn't working for me before, but it appears to be
now; perhaps I picked up a fix in a merge with your tree.

> # Note: most of this should really be in a generic macro like
> # base_user_program($1, foo)
> 
> Good idea.  Please send me a patch and convert some of the policy to using it 
> as an example.  ;)

Heh.  There are a number of things I want to do first...but it should go
on the TODO list.

> file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t)
> create_dir_file($1, $2_home_spamassassin_t)
> 
> The first line does everything that the second line does.  Also consider 
> whether you need the full capabilities of the file_type_auto_trans() macro, 
> does spamassasin really need to create sockets under the user home directory?
> Maybe the following will do:
> file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t, file)

I don't think that's enough, because I want it to be able to create the
~/.spamassassin directory too.

> I've put spamd.te in my tree.

Cool.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
