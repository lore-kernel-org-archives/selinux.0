Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA20805
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:24:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA01156
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 07:22:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id HAA01152 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 07:22:42 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Policy questions
Date: Sat, 27 Jul 2002 09:24:14 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726114247.3A14A14D1@lyta.coker.com.au> <20020727044221.GE18313@snoopy.apana.org.au>
In-Reply-To: <20020727044221.GE18313@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <20020727072415.31E06B01@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 27 Jul 2002 06:42, Brian May wrote:
> On Fri, Jul 26, 2002 at 01:42:46PM +0200, Russell Coker wrote:
> > domains/misc/custom is a custom configuration file (and is something
> > that I'm using for experimental stuff). I disregarded that part of your
> > diff.
>
> Hmmm... Some changes look like they should be moved to another place,
> eg:
>
> # allow writes to devpts devices
> allow domain devfs_t:chr_file rw_file_perms;
> allow domain devpts_t:dir search;

The reason those are in domains/misc/custom.te is because they are wrong.  
The devfs_t line is for devfs breakage, and the devpts_t line was something I 
put in before I got the devpts_t:dir stuff sorted out properly (still not 
sure I'm finished).  These allow domain rules will never go into any release.

> Just as another issue, this seems to be broken:
>
> # allow regular users to ping
> in_user_role(ping_t);
>
> As I can't ping as a regular user ;-).

You need the following as well:
domain_auto_trans(unpriv_userdomain, ping_exec_t, ping_t)

> > Why is the following needed?
> > -allow local_login_t faillog_t:file append;
> > +allow local_login_t faillog_t:file { append read write };
>
> Because I got errors if it didn't have all those privileges.

What do you do to get such errors?

> I suspect it isn't a simple append operation.
>
> For instance, the faillog program has an -m  flag that sets the
> maximum number of login attempts allowed. The -r flag resets the
> count of login failures.

faillog is labelled bin_t and appears (from it's man page) to be only run by 
the administrator.  sysadm_t has write access to the file...

> What would be nice is some tool that will identify duplicate rules...

Yes.

> > Is oav-update.te really an independant domain?  Maybe it should be
> > included in one of the other files.  NB If you have oav-update.te but not
> > amavis.te then your policy won't compile...  At the moment I'll leave it
> > out of my tree for this reason.
>
> Yes, I think it is. It is a program that does nothing but download
> the latest virus signatures, so it needs to have write access
> to the signature files. It is used both by scannerdaemon and clamav.

Why not include it in the clamav.te file then?

> You could argue that this should be moved:
> >less file_contexts/program/kaffe.fc
>
> /usr/lib/kaffe/bin/kaffe        system_u:object_r:bin_t

Should be in types.te I guess.

> > I'm not sure if the following change to daemon_domain macro is what we
> > really want, I'll have to think about it.
> > -domain_auto_trans(initrc_t, $1_exec_t, $1_t)
> > +domain_auto_trans({ init_t initrc_t }, $1_exec_t, $1_t)
>
> That was your change ;-).
>
> I am not sure why it was required...

For daemons that get started from inittab...

> - Check why clamscan wants to connect to itself using a Unix socket
>   stream...

Lots of programs do that, just allow it.  It doesn't do any harm connecting 
to itself.

> Anything I have forgotten?

I don't think so.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
