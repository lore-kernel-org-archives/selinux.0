Message-ID: <1344456337.22629.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: A filename to label translation daemon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, lennart@poettering.net, dwalsh@redhat.com
Date: Wed, 08 Aug 2012 16:05:37 -0400
In-Reply-To: <1344454290.25533.12.camel@localhost>
References: <1344454290.25533.12.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-08-08 at 15:31 -0400, Eric Paris wrote:
> We know that utilities like install disable their SELinux support
> because of the enormous amount of time it takes to load the matchpathcon
> regex database.  We know that systemd spends time loading the database
> at least twice.  Other utilities like the krb5libs complain about the
> size and time it takes to load the database.  We've added hacks (I
> believe all in Fedora, but maybe upstream as well) which try to pare
> down the database to some prefix(es) on database load.  If systemd only
> needs to label in /var why load all the stuff for /etc?  These prefix
> hacks don't work particularly well as fallback labels (such as
> default_t) are hard to capture and the prefixes cannot be long as the
> regexes are usually quite short.  They also don't work well with label
> equivalencies.
> 
> So today I wrote a little daemon which listens in the abstract namespace
> for requests and returns the context.  It really really rough, I admit,
> but it works quite well.  My first perf numbers looking at /home/eparis
> make sense:
> 
> $ ./initonce /home/eparis
>  0.180 seconds used by the processor.
> $ ./initalways /home/eparis
>  19.200 seconds used by the processor.
> $ ./client /home/eparis
>  0.570 seconds used by the processor.
> 
> If I init the DB one time and do the same lookup (for /home/eparis) 1000
> times it takes .18 seconds.  Doing 1000 lookups init-ing and fini-ing
> the db every time it took 19.2.  Connecting to the server and asking
> 1000 times took .57 seconds.  This means that if you have to do about 48
> lookups, it's faster to do your own init.  If <48, you should use the
> server.
> 
> The I tried again with a different pathname (and get very different
> results)
> 
> $ ./initonce /var/www/html/cgi-bin
>  1.510 seconds used by the processor.
> $ ./initalways /var/www/html/cgi-bin
>  42.790 seconds used by the processor.
> $ ./client /var/www/html/cgi-bin
>  0.600 seconds used by the processor.
> 
> These I cannot explain.  How the heck is local slower when the time to
> init the db is not taken into account at all?  I'm clueless here.  But
> still, the client server model doesn't look like a bad idea.
> 
> I'm attaching my server, my client, and my 2 local test programs.
> Thoughts?
> 
> *having the daemon listen and update the db on policy load is a todo

Not sure how this helps systemd, as it runs first (by definition) and
loads the file_contexts configuration before it starts any other
daemons, right?  Now if you wanted systemd to export this as a service
to everything else, that might make sense.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
