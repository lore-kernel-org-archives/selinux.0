Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4K6HGRb016574
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 02:17:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4K6HDAR002640
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 06:17:13 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4K6HCHn002636 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 06:17:12 GMT
Date: Thu, 20 May 2004 06:14:35 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520061435.GH24597@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <200405200600.46881.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405200600.46881.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 06:00:46AM +1000, Russell Coker wrote:
> On Thu, 20 May 2004 04:11, Steve Greenland <steveg@moregruel.net> wrote:
> > It feels very misleading and confusing to overload it that way, and I
> > don't see the difference between checking for "system_u" and "*system*".
> >
> > Except that "system_u" *is* a valid username, therefore raising the
> > possiblity of conflict between /etc/crontab and the crontab of user
> > system_u.
> 
> If you are using SE Linux then a user name of "system_u" is not going to 
> work, /bin/login etc can't launch shells with system_u as the identity.
> 
> I guess we can have the SE Linux code in crond know that "*system*" means that 
> the identity of "system_u" should be used.
 
 i reworked the patch to add an extra argument to process_crontab.
 the behaviour of the 2nd argument, fname, is left untouched.
 a third argument is added which is set to "system_u" where needed,
 and is identical to the 2nd argument, fname, where needed.
 
 it makes it clear that the two purposes are separate and distinct,
 and i believe it achieves what you intend by the above, which
 would have been to strcmp (fname, "*system*") == 0 inside
 process_crontab and to special-case call get_default_context
 with "system_u" in that instance, yes?

 the extra-argument-patch does the equivalent of that.

 l.

 p.s. this is completely offtopic, but i wish the default world
 language was sanscrit or german or something because when
 describing computer stuff i end up hyphenating english words
 together a lot.  oh well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
