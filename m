Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CBmWDh001236
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 07:48:32 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CBlZID022523
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 11:47:36 GMT
Received: by vws15 with SMTP id 15so5142897vws.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 04:48:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100712140130.468b7b42@debian>
References: <201007121922.48247.russell@coker.com.au>
	<20100712140130.468b7b42@debian>
Date: Mon, 12 Jul 2010 07:48:29 -0400
Message-ID: <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
Subject: Re: clamav RWX
From: Eric Paris <eparis@parisplace.org>
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2010/7/12 Török Edwin <edwintorok@gmail.com>:

> [*]
> I have some plans to make the JIT work without RWX, since ClamAV has 2
> phases:
>  - load DB, JIT compile bytecode (should use only RW- mapping, but
>   currently needs RWX)
>  - execute (JIT compiled) bytecode (should change mapping to be R-X)

Just so you know that is going to require the same permissions.
(Hopefully) The only way to get around the SELinux permissions is to
have 2 separate mappings.  Basically in really really rough sudo-code,

file = open(filename, RWX);
unlink(file);
truncate(file, however big you need);
exec_area = mmap(PROT_EXEC, file);
write_area = mmap(PROT_WRITE, file);

then do all of the writing to write_area and all of the executing in exec_area.

http://people.redhat.com/drepper/selinux-mem.html

Simply using mremap to change a mapping from PROT_WRITE to PROT_EXEC
will cause the same problems as just doing it at the same time.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
