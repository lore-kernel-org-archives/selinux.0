Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JIBQRb012832
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:11:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JIBNAR028885
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 18:11:23 GMT
Received: from fury.moregruel.net (fury.moregruel.net [64.62.190.193])
        by jazzband.ncsc.mil  with ESMTP id i4JIBNHn028881 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 18:11:23 GMT
Date: Wed, 19 May 2004 13:11:20 -0500
From: Steve Greenland <steveg@moregruel.net>
To: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040519181120.GA6115@moregruel.net>
Reply-To: Steve Greenland <steveg@moregruel.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519140239.GF4221@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 19-May-04, 09:02 (CDT), Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote: 
> On Wed, May 19, 2004 at 09:30:53AM -0400, Stephen Smalley wrote:
> 
> > > i take it that this is a more "informative" string
> > > than "*system*" but it is equally as non-username-ish
> > > as "*system*" is.
> > 
> > It conveys to the SELinux code that we want a security context
> > appropriate for system cron jobs transparently, as system_u is already
> > the SELinux user identity for system processes.  And it doesn't hurt
> > anything, as neither "*system*" nor "system_u" should exist in
> > /etc/passwd.
>  
>   then the maintainer of debian crond needs to be authoritatively
>   informed of this, as it will help reassure him that no damage is
>   done by the change.

I've been informed, I just don't buy it. The only thing that name
is used for is to generate "names" for the (internal) database, to
associate it with a particular entry in the list of crontabs, since the
file names are possibly in conflict with system usernames. The only
legitimate use for it is to look up entries in that list. It's *NOT* the
username associated with the crontab. You can't even use it directly,
because the while the "name" of the /etc/crontab entry is "*system*",
the names of the /etc/cron.d entries are "*system*/<filename>" (e.g.
/etc/cron.d/foo maps to "*system*/foo").

It feels very misleading and confusing to overload it that way, and I
don't see the difference between checking for "system_u" and "*system*".

Except that "system_u" *is* a valid username, therefore raising the
possiblity of conflict between /etc/crontab and the crontab of user
system_u.

The database entry (struct _user) has a field for username. That's where
this belongs. 

>  this concatenation will of course make the strcmp against "*system*",
>  at line 245, FAIL in the case where the 2nd arg to process_crontab
>  is "*system*someotherinformation"
> 
>  this MAY just be a bug in the debian version of cron: i cannot tell
>  because i do not know enough about it.

There's no strcmp at line 245 of the debian database.c. What you're
looking at (probably) is this, around line 327 (beginning of
process_crontab()):

#ifdef DEBIAN
    /* If the name begins with *system*, don't worry about password -
     it's part of the system crontab */
    if (strncmp(fname, "*system*", 8) && !(pw = getpwnam(uname))) {
#else
    if (strcmp(fname, "*system*") && !(pw = getpwnam(uname))) {
#endif


And will work fine no matter what "*system*" is (well, so long as it's 8
characters, and that's trivially fixed with a sizeof()).

>  is against a vixie-cron where the 2nd argument to process_crontab
>  is "*system" in BOTH calls to process_crontab, at lines 94 and 136
>  of database.c.
> 
>  i can only point out the discrepancy between the Fedora vixie-cron
>  and the Debian 3.0 cron (based on vixie-cron): i cannot make an informed
>  statement about what is right.

You need to keep the entries for /etc/crontab and /etc/cron.d/ seperate
or you won't be able to pick up changes in the files. That sounds like
a Fedora bug, but since I've not looked at that code recently, all I'll
say is that it's worth looking at.

Steve

-- 
Steve Greenland
    The irony is that Bill Gates claims to be making a stable operating
    system and Linus Torvalds claims to be trying to take over the
    world.       -- seen on the net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
