Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5BG890l001211
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 12:08:09 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5BG9enB014778
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 16:09:40 GMT
Received: by gwb20 with SMTP id 20so83754gwb.12
        for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 09:08:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100611154117.GS21875@tamriel.snowman.net>
References: <4C11CE43.7000509@ak.jp.nec.com>
	<4C125496.1060107@2ndquadrant.com>
	<20100611154117.GS21875@tamriel.snowman.net>
Date: Fri, 11 Jun 2010 11:08:08 -0500
Message-ID: <AANLkTimUrgvWLr0A8dorFZ1TTrT4YZDj6M7pNHNs1L_A@mail.gmail.com>
Subject: Re: Report of PGcon2010
From: Xavier Toth <txtoth@gmail.com>
To: Stephen Frost <sfrost@snowman.net>
Cc: Greg Smith <greg@2ndquadrant.com>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        SELinux <selinux@tycho.nsa.gov>, Robert Haas <robertmhaas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2010 at 10:41 AM, Stephen Frost <sfrost@snowman.net> wrote:
> Greg, all,
>
> * Greg Smith (greg@2ndquadrant.com) wrote:
>> This pushes off the problem of how to keep labels consistent in the face
>> of things like table changes to being a database superuser only task,
>> not one you can delegate to other users.
>
> As an additional side-note that might be relevant to this community,
> I've been talking to some of the other PG developers (Tom Lane, Robert
> Haas, etc) about adding more granularity to the PG role options to
> eliminate the need to have an actual PG "super-user".  There are still
> some specific tasks which require super-user (in particular, the
> "replication" user must be a super-user, the user which can issue
> pg_start_backup/pg_stop_backup commands, etc), but if we make those into
> separately tracked options, we could provide a system with no user
> having the actual "super-user" bit set which would still be very usable.
>
> I'm hoping to target that for 9.1, but I certainly can't make any
> promises.  One thing to note in all of this, as has likely been said
> here already, right now this is just about all spare-time work by the PG
> individuals and companies who are interested in it.  Organizations
> interested in this speaking up that they'd like to use it, or even
> better sponsor work on it, in whatever way they can, would certainly
> increase the availability of PG community resources for this project and
> things like RLS being added to PG.
>
>        Thanks!
>
>                Stephen
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkwSWR0ACgkQrzgMPqB3kigJ7wCfcPofOMQYgr+9AGf+AskPZWWz
> ipUAnRcZqQ8NZjYLvpmrFbSDN9FHqQOC
> =C/J2
> -----END PGP SIGNATURE-----
>
>

Is there any hope for some sort of Common Criteria
testing/certification of SELinux PostgreSQL?

Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
