Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA23586
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 22:42:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA01791
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 02:41:22 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id CAA01784 for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 02:41:19 GMT
Date: Sun, 28 Jul 2002 12:42:41 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Message-ID: <20020728024241.GA7217@snoopy.apana.org.au>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726114247.3A14A14D1@lyta.coker.com.au> <20020727044221.GE18313@snoopy.apana.org.au> <20020727072415.31E06B01@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020727072415.31E06B01@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 27, 2002 at 09:24:14AM +0200, Russell Coker wrote:
> > As I can't ping as a regular user ;-).
> 
> You need the following as well:
> domain_auto_trans(unpriv_userdomain, ping_exec_t, ping_t)

...and allow:

allow ping_t user_devpts_t:chr_file { getattr read write };
allow ping_t user_gph_t:fd { use };

otherwise it won't display the results ;-).

Of course, this really requires a macro...

> > > Why is the following needed?
> > > -allow local_login_t faillog_t:file append;
> > > +allow local_login_t faillog_t:file { append read write };
> >
> > Because I got errors if it didn't have all those privileges.
> 
> What do you do to get such errors?
> 
> > I suspect it isn't a simple append operation.
> >
> > For instance, the faillog program has an -m  flag that sets the
> > maximum number of login attempts allowed. The -r flag resets the
> > count of login failures.
> 
> faillog is labelled bin_t and appears (from it's man page) to be only run by 
> the administrator.  sysadm_t has write access to the file...

I think you misunderstood me.

login obviously needs read access to faillog, so it can read the value
written to by faillog -m, and it needs write access so it can write
the value read by -r.

At least thats the way I read the man page.
> > Yes, I think it is. It is a program that does nothing but download
> > the latest virus signatures, so it needs to have write access
> > to the signature files. It is used both by scannerdaemon and clamav.
> 
> Why not include it in the clamav.te file then?

Because you still need it for scannerdaemon even if you do not use
clamav.

> > You could argue that this should be moved:
> > >less file_contexts/program/kaffe.fc
> >
> > /usr/lib/kaffe/bin/kaffe        system_u:object_r:bin_t
> 
> Should be in types.te I guess.

Moved in my version.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
