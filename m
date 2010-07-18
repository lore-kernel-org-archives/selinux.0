Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6IHsR8S002661
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 13:54:27 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6IHuQKE001339
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 17:56:27 GMT
Received: by eydd26 with SMTP id d26so942660eyd.12
        for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 10:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201007182205.10960.russell@coker.com.au>
References: <201007182205.10960.russell@coker.com.au>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Sun, 18 Jul 2010 13:54:05 -0400
Message-ID: <AANLkTimgmHVcXK_6MRnr-uGi4R5XSymdANqThNeZvgJd@mail.gmail.com>
Subject: Re: transactions in semanage
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russell!

On Sun, Jul 18, 2010 at 08:05, Russell Coker <russell@coker.com.au> wrote:
> Has anyone considered a batch/transaction interface for semanage?
>
> The idea would be that you could redirect input from a script containing a
> list of commands, and either all of them would succeed and be committed to
> disk or none of the changes would apply and an error message would inform the
> user of the cause of the problem.
>
> The first benefit of this would be an improvement in run-time.  Currently
> semanage can be quite time consuming on a low-end system and if you have a
> large number of commands to run (EG a for loop that has each iteration adding
> a number of fcontext rules or user identities) then it could be a real drag.

This sounds like a good direction to move in, but if you're interested
in run-time there's much lower hanging fruit.  Matt Robertson (a
coworker of mine) just posted a relatively short patch that cuts 80%
off the runtime of the "semodule" by allowing dynamically-sized hash
tables.  Specifically, in his original profile results a simple
"semodule -i" was spending a whopping 50% of its time in strcmp().

It looks like a substantial additional reduction can be obtained by
adding support for lzma or gzip compression (or maybe even disable it
entirely) instead of the CPU-intensive bzip2.  On top of that, there
seem to be at least a few O(X^2) algorithms that may be rewritten for
efficiency.

So while I personally think that a transactional interface would be
good (perhaps similar to "iptables-load" and "iptables-restore"?),
there's much more important things to fix with regards to runtime.
Asking that the admin wait 2 minutes to add a new SELinux user is just
a bit much :-D.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
