Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA20389
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 00:42:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA27049
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 04:40:59 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id EAA27045 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 04:40:56 GMT
Date: Sat, 27 Jul 2002 14:42:21 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Message-ID: <20020727044221.GE18313@snoopy.apana.org.au>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726114247.3A14A14D1@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020726114247.3A14A14D1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 26, 2002 at 01:42:46PM +0200, Russell Coker wrote:
> domains/misc/custom is a custom configuration file (and is something
> that I'm using for experimental stuff). I disregarded that part of your
> diff.

Hmmm... Some changes look like they should be moved to another place,
eg:

# allow writes to devpts devices
allow domain devfs_t:chr_file rw_file_perms;
allow domain devpts_t:dir search;

Just as another issue, this seems to be broken:

# allow regular users to ping
in_user_role(ping_t);

As I can't ping as a regular user ;-).

> For clamav.te, I think you should do something similar to what I have done 
> for the irc domain.  I've partially hacked the appropriate code into my tree. 
>  Doing that will allow multiple user domains easily (the way you did it will 
> require editing clamav.te every time you add a new user domain).

Good point.

> Also does it make sense to scan a virus as sysadm anyway?

Why prevent the sysadm from scanning for viruses?

> Why is the following needed?
> -allow local_login_t faillog_t:file append;
> +allow local_login_t faillog_t:file { append read write };

Because I got errors if it didn't have all those privileges.

I suspect it isn't a simple append operation.

For instance, the faillog program has an -m  flag that sets the
maximum number of login attempts allowed. The -r flag resets the
count of login failures.

> For the following, shouldn't the .so file in question be given a type of 
> shlib_t?
> +# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-14
> +
> +# /usr/lib/gconv/ISO8859-1.so
> +allow local_login_t lib_t:file { execute };

Good point.

> The following is already in my tree, are you sure you have a recent version?
> +# allow checking /var/run/lprng directory
> +allow checkpc_t lpd_var_run_t:dir { getattr };

Yes. I am not always 100% accurate when merging your changes in with
my changes, and sometimes get duplicates...

What would be nice is some tool that will identify duplicate rules...

> The following is in the daemon_domain macro:
> +# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-13
> +file_type_auto_trans(nscd_t, var_run_t, var_run_nscd_t)

Strange. I wouldn't have added it if it wasn't required (or would I?).
I need to check this.

> 
> Is oav-update.te really an independant domain?  Maybe it should be included 
> in one of the other files.  NB If you have oav-update.te but not amavis.te 
> then your policy won't compile...  At the moment I'll leave it out of my tree 
> for this reason.

Yes, I think it is. It is a program that does nothing but download
the latest virus signatures, so it needs to have write access
to the signature files. It is used both by scannerdaemon and clamav.

> BTW  Make sure you put your name at the top of every .te file you write so 
> that you get any credit/flames that you deserve.  ;)  Also make sure you 
> comment any non-obvious .te files so people can determine what they are for.

I meant to do that, obviously I missed some :-(

> Your diff is missing kaffe.te.

It was a zero byte file...

Diff doesn't seem to do zero byte files.

You could argue that this should be moved:
>less file_contexts/program/kaffe.fc 
/usr/lib/kaffe/bin/kaffe        system_u:object_r:bin_t

While I am on this topic, can I suggest that something be done about
file_contexts/program/mail.fc, it is also a zero byte file...

> I think that some of my postfix changes already did what you wanted, and I 
> added the tcp_socket changes.  Please check my latest version and see how it 
> compares to what you need.  I didn't include the postfix flush changes 
> because I don't want to change too many things at once.  But the concept 
> seems good.

Ok, I will look.

> I'm not sure if the following change to daemon_domain macro is what we really 
> want, I'll have to think about it.
> -domain_auto_trans(initrc_t, $1_exec_t, $1_t)
> +domain_auto_trans({ init_t initrc_t }, $1_exec_t, $1_t)

That was your change ;-).

I am not sure why it was required...

> I'll put a revised set of my policy on my web site soon incorporating most of 
> your changes.

To summarize (so I don't forget):

Changes by Stephen:
- remove writeable_t.

Changes made by Russell:
- change irc.
- new version of amavisd.

Comments made by Russell:
- don't include domains/misc/custom.te
- different formatting of ifdef preferred.

Future work:
- Why does cardmgr need to create device nodes? Should this be
  dontaudit?
- Change clamav to be similar to IRC.
- Relabel /usr/lib/gconv/*.so to shlib_t?
- Remove 0 byte files, they don't show up in patches.
- Why is postdrop accessing /dev/pts/1?
- Check why amavis seems to be broken, it can't search /usr/bin.
- Check why clamscan wants to connect to itself using a Unix socket
  stream...

Changes I need to make:
- Add name to top of oav-update.te
- Remove local changes at end of domains/program/lpd.te and domains/program/nscd.te
- Check postfix.

Anything I have forgotten?
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
