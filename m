Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LAJvI4014525
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 06:19:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4LAJXQj029880
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 10:19:33 GMT
Received: from narya.grin.hu (Narya.grin.hu [195.38.113.130])
	by jazzswing.ncsc.mil  with ESMTP id h4LAJRxS029870
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 10:19:32 GMT
Date: Wed, 21 May 2003 12:19:44 +0200
From: Peter Gervai <grin@tolna.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy for exim and/ or tiger?
Message-ID: <20030521101944.GG32563@narya.grin.hu>
Reply-To: grin@tolna.net
References: <200305152349.28038.tk-selinux@datas-world.de> <20030520080652.GW32563@narya.grin.hu> <200305202049.40285.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305202049.40285.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 20, 2003 at 08:49:40PM +1000, Russell Coker wrote:
> On Tue, 20 May 2003 18:06, Peter Gervai wrote:

> > # not strictly required
> > #file_type_auto_trans(exim_t, etc_t, etc_exim_t)

> I would change that comment to "not desired for normal operation".  Allowing 
[...]

Since these are draft versions (as you may notice from the large amounts of
commented parts) the comments often contain unnecessary or undesired parts
of the policy. If things seem not to break I going to remove all these
comments from the files. Apologies for the inconveniece reading these.

> > # Write to /var/spool/mail and /var/spool/mqueue.
> 
> Either the above comment is wrong or you are missing a file contexts entry for 
> /var/spool/mqueue.  If exim does use /var/spool/mqueue then I recommend that 
> you use type mqueue_spool_t for it so that you can convert a Sendmail system 
> to Exim without too much pain.

Comment is misleading since exim does not use mqueue but
/var/spool/exim/*/*, but the actual policy reflects reality. I'll change
this comment which is the remains of the sendmail policy I started editing
from.

> > allow exim_t exim_var_run_t:dir rw_dir_perms;
> > allow exim_t exim_var_run_t:file rw_file_perms;
> 
> The above should be taken care of by daemon_domain().

Weird. I started inserting policy lines at the end when getting deny entries
in the syslog. I'll check this, but I can't tell why were they required (I
don't recall inserting the daemon_domain later...)

> > I have policy for pine, I mean, it's something like a policy but looks like
> > a horrible rape on selinux for me, since it contains plenty of horrible
> > permissions granted. I wonder whether it can be made working without
> > these...
[...]

> What is the aim of the pine policy anyway?  To grant pine some access that 
> user_t is not given?  Or to lock down pine because it's got a bad history?

One reason is its bad history, other is the amount of weird permissions it
requires, I do not know any other way to make it work. Is there any other
way to make it fully functioning? It wants to rw ~mail, send mail by smtp
and connect to local mail daemons, and some stuff I can't even tell the
reason of.

Could it work without any special policy, is this what you mean?

Peter

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
