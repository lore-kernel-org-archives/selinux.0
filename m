Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JKNFRb013911
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 16:23:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JKNCAR009767
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 20:23:12 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4JKNBHn009760 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 20:23:11 GMT
Date: Wed, 19 May 2004 20:00:57 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040519200057.GD24597@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519181120.GA6115@moregruel.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 01:11:20PM -0500, Steve Greenland wrote:
> On 19-May-04, 09:02 (CDT), Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote: 
> > On Wed, May 19, 2004 at 09:30:53AM -0400, Stephen Smalley wrote:
> > 
> > > > i take it that this is a more "informative" string
> > > > than "*system*" but it is equally as non-username-ish
> > > > as "*system*" is.
> > > 
> > > It conveys to the SELinux code that we want a security context
> > > appropriate for system cron jobs transparently, as system_u is already
> > > the SELinux user identity for system processes.  And it doesn't hurt
> > > anything, as neither "*system*" nor "system_u" should exist in
> > > /etc/passwd.
> >  
> >   then the maintainer of debian crond needs to be authoritatively
> >   informed of this, as it will help reassure him that no damage is
> >   done by the change.
> 
> I've been informed, I just don't buy it. The only thing that name
> is used for is to generate "names" for the (internal) database, to
> associate it with a particular entry in the list of crontabs, since the
> file names are possibly in conflict with system usernames. The only
> legitimate use for it is to look up entries in that list. It's *NOT* the
> username associated with the crontab. You can't even use it directly,
> because the while the "name" of the /etc/crontab entry is "*system*",
> the names of the /etc/cron.d entries are "*system*/<filename>" (e.g.
> /etc/cron.d/foo maps to "*system*/foo").
> 
> It feels very misleading and confusing to overload it that way, and I
> don't see the difference between checking for "system_u" and "*system*".
> 
> Except that "system_u" *is* a valid username, 

 okay, let's think this through.
 
 it is not a username, it is never expected to be a username...

 ... therefore, i take it that you mean that the letters "system_u"
 _could_ be used as a username, whereas "*" is an invalid character
 which, _if_ used in /etc/passwd, would cause a login error.

 and i take it that _that_ is why you object to its use, yes?


> therefore raising the
> possiblity of conflict between /etc/crontab and the crontab of user
> system_u.

 it's worth double-checking, and russell would be able to confirm:
 on an SELinux system, system_u _can_ never be a valid username...

 ... but that doesn't rule out 

 okay, would "*system_u*" do?

 the thing is that from what i gather, SELinux actually checks things
 via the username that it sees cron jobs create.

 ... *click*.  russell, stephen, isn't that bad??

 surely, things should be done via a SID not a username??

 no ugliness is being buried here, is it? :)


> >  this concatenation will of course make the strcmp against "*system*",
> >  at line 245, FAIL in the case where the 2nd arg to process_crontab
> >  is "*system*someotherinformation"
> > 
> >  this MAY just be a bug in the debian version of cron: i cannot tell
> >  because i do not know enough about it.
> 
> There's no strcmp at line 245 of the debian database.c. What you're
> looking at (probably) is this, around line 327 (beginning of
> process_crontab()):

 yes.

> #ifdef DEBIAN
>     /* If the name begins with *system*, don't worry about password -
>      it's part of the system crontab */
>     if (strncmp(fname, "*system*", 8) && !(pw = getpwnam(uname))) {
> #else
>     if (strcmp(fname, "*system*") && !(pw = getpwnam(uname))) {
> #endif
> 
> 
> And will work fine no matter what "*system*" is (well, so long as it's 8
> characters, and that's trivially fixed with a sizeof()).
 
  around line 215 of cron-3.0pl1/database.c:

		(void) strcpy(fname,"*system*");
		sprintf(tabname,"%s/%s", SYSCRONDIR, dp->d_name);

		/* statbuf is used as working storage by process_crontab() --
		   current contents are irrelevant */
		process_crontab("root", fname, tabname,
				&statbuf, &new_db, old_db);

 yep, you're right: i thought that was sprintf (fname, ... )
 where in fact it's sprintf (tabname).

 so yep, panic over.

 in both vixie-cron and cron3.0pl1 database.c are the same.


> >  is against a vixie-cron where the 2nd argument to process_crontab
> >  is "*system" in BOTH calls to process_crontab, at lines 94 and 136
> >  of database.c.
> > 
> >  i can only point out the discrepancy between the Fedora vixie-cron
> >  and the Debian 3.0 cron (based on vixie-cron): i cannot make an informed
> >  statement about what is right.
> 
> You need to keep the entries for /etc/crontab and /etc/cron.d/ seperate
> or you won't be able to pick up changes in the files. That sounds like
> a Fedora bug, but since I've not looked at that code recently, all I'll
> say is that it's worth looking at.

 no, it's fine: as explained above it's my misreading of the sprintf
 statement in database.c.

 sorry about that.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
