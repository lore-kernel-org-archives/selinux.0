Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4AHt0ih019039
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 13:55:00 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4AHt08W001499
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 17:55:00 GMT
Subject: Re: Bugs with bool_ids usage (libsepol)
From: Karl MacMillan <kmacmillan@tresys.com>
To: Cedric Roux <Cedric.Roux@eurecom.fr>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
Content-Type: text/plain; charset=utf-8
Date: Wed, 10 May 2006 13:52:16 -0400
Message-Id: <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-10 at 17:17 +0200, Cedric Roux wrote:
> Dear SELinux people,
> 
> there is a bug with the way you handle bool_ids in libsepol.
> For example, we see this code:
>         for (i = 0; i < needle->nbools; i++)
>                 new_node->bool_ids[i] = needle->bool_ids[i];
> in libsepol-1.12/src/conditional.c:cond_node_find
> The only problem is that bool_ids is defined as:
>         uint32_t bool_ids[COND_MAX_BOOLS];
> with:
> #define COND_MAX_BOOLS 5
> in libsepol-1.12/include/sepol/policydb/conditional.h
> 
> But we have that nbools may be bigger than COND_MAX_BOOLS.
> That would result in a funny behavior if someone somewhere
> on this little planet decided to put more than COND_MAX_BOOLS
> boolean variables in an if statement, don't you think?
> 
> I tried to do some tests.
> 
> With something like (manipulating policy.conf from refpolicy):
>     if (ftpd_is_daemon && secure_mode && secure_mode_insmod && 
>         allow_cvs_read_shadow && allow_execmem && allow_kerberos && 
>         allow_smbd_anon_write && allow_ypbind && allow_execmod) {
>            DO_SOMETHING
>     }
> checkpolicy crashes on a malloc (so I need 9 boolean variables for a
> malloc to be very unhappy with the state of the heap).
> 
> You should do something about this I think.
> 
> I didn't get the point with the bool_ids yet, so I don't know
> how to fix that. Maybe do something like:
>         for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
> is the solution, maybe not. It's up to you!
> 
> Anyway you will need to check every usage of bool_ids.
> 

Thanks for the bug report. The code in question is making an incorrect
assumption about what COND_MAX_BOOLS is used for. That vaguely named
define is not intended to limit the number of unique booleans in a
conditional expression. The only limit in conditional expressions should
be the stack depth.

I should be able to get a patch to fix this out sometime soon.

Thanks,

Karl

> Take care of yourself,
> Cédric.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
