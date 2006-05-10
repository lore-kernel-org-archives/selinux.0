Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4AFH9e0014830
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 11:17:09 -0400
Received: from smtp.eurecom.fr (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4AFH78W011652
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 15:17:08 GMT
Received: from monza.eurecom.fr (localhost [127.0.0.1])
	by smtp.eurecom.fr (8.13.1/8.13.1) with ESMTP id k4AFH5Ck005860
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 17:17:05 +0200 (CEST)
Date: Wed, 10 May 2006 17:17:06 +0200 (CEST)
From: Cedric Roux <Cedric.Roux@eurecom.fr>
To: selinux@tycho.nsa.gov
Subject: Bugs with bool_ids usage (libsepol)
Message-ID: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear SELinux people,

there is a bug with the way you handle bool_ids in libsepol.
For example, we see this code:
        for (i = 0; i < needle->nbools; i++)
                new_node->bool_ids[i] = needle->bool_ids[i];
in libsepol-1.12/src/conditional.c:cond_node_find
The only problem is that bool_ids is defined as:
        uint32_t bool_ids[COND_MAX_BOOLS];
with:
#define COND_MAX_BOOLS 5
in libsepol-1.12/include/sepol/policydb/conditional.h

But we have that nbools may be bigger than COND_MAX_BOOLS.
That would result in a funny behavior if someone somewhere
on this little planet decided to put more than COND_MAX_BOOLS
boolean variables in an if statement, don't you think?

I tried to do some tests.

With something like (manipulating policy.conf from refpolicy):
    if (ftpd_is_daemon && secure_mode && secure_mode_insmod && 
        allow_cvs_read_shadow && allow_execmem && allow_kerberos && 
        allow_smbd_anon_write && allow_ypbind && allow_execmod) {
           DO_SOMETHING
    }
checkpolicy crashes on a malloc (so I need 9 boolean variables for a
malloc to be very unhappy with the state of the heap).

You should do something about this I think.

I didn't get the point with the bool_ids yet, so I don't know
how to fix that. Maybe do something like:
        for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
is the solution, maybe not. It's up to you!

Anyway you will need to check every usage of bool_ids.

Take care of yourself,
Cédric.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
