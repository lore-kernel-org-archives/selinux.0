Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6G1AWHa021004
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:10:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6G1AVH5011806
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 01:10:31 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6G1ATRX011801 for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 01:10:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: first pass at a spamassassin/spamc/spamd policy
Date: Wed, 16 Jul 2003 11:10:23 +1000
References: <1058295391.15102.97.camel@columbia>
In-Reply-To: <1058295391.15102.97.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307161110.23222.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Jul 2003 04:56, Colin Walters wrote:
> Attached is a first attempt at a spamassassin policy.  It is not going
> to be sufficient for most typical users though, because we don't
> currently have a clean way to transition from procmail_t to e.g.
> user_spamc_t.
>
> Russell and I discussed this issue on IRC last night, and he was of the
> opinion that we should create a shell script wrapper for procmail which

I was thinking of a wrapper written in C which is compiled.  Do we even have 
enough utility programs to allow such things to be written in shell scripts?

> ifdef(`procmail.te',`
> domain_auto_trans($1_procmail_t, spamc_exec_t, $1_spamc_t)
> ')
> in spamassassin_macros.te.
>
> One other issue I ran into; what's a good way to specify that a program
> may interact with the user?  Right now I'm doing:
>
> allow $1_$2_t privfd:fd use;
> allow $1_$2_t userpty_type:chr_file rw_file_perms;
>
> But this seems a bit unclean.  Any suggestions?

When you have the wrapper as discussed you just need the following:
allow $1_$2_t privfd:fd use;
allow $1_$2_t { $1_devpts_t $1_tty_device_t }:chr_file rw_file_perms;

Also another possibility is for the wrapper program to change the type of the 
terminal device in a similar manner to newrole and then change it back after 
the program is complete.  Then the program can't run amok on terminals from 
other sessions by the same user.

tmp_domain(spamd)
allow spamd_t tmp_t:dir { getattr read };
The second line should not be needed, the first line should do it.

# Note: most of this should really be in a generic macro like
# base_user_program($1, foo)

Good idea.  Please send me a patch and convert some of the policy to using it 
as an example.  ;)

file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t)
create_dir_file($1, $2_home_spamassassin_t)

The first line does everything that the second line does.  Also consider 
whether you need the full capabilities of the file_type_auto_trans() macro, 
does spamassasin really need to create sockets under the user home directory?
Maybe the following will do:
file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t, file)

I've put spamd.te in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
