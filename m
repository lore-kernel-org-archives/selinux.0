Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KDwcRb018773
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 09:58:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KDwYAR027254
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 13:58:34 GMT
Received: from smtp803.mail.ukl.yahoo.com (smtp803.mail.ukl.yahoo.com [217.12.12.140])
        by jazzband.ncsc.mil  with SMTP id i4KDwWHn027240 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 13:58:32 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 20 May 2004 13:58:30 -0000
Date: Thu, 20 May 2004 13:55:53 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: FAM uses seteuid and setegid
Message-ID: <20040520135553.GD8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net> <1085056946.521.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085056946.521.65.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 08:42:26AM -0400, Stephen Smalley wrote:

> On Thu, 2004-05-20 at 08:15, Luke Kenneth Casson Leighton wrote:
> > just taking a look at famd, which uses seteuid and setegid before
> > going and 'avin a look at files (Cred::Implementation::become_user())
> > 
> > so, famd is designed to "effectively" set its user and group ids,
> > such that any file access is done as these, whilst still remaining
> > actually running as root.
> > 
> > ... so... what tricks can be done that are equivalent to this?
> > 
> > setfscreatecon doesn't apply because that's presumably for file
> > creation, and famd does file access not file creation.
> > 
> > setexeccon doesn't apply because there _are_ no relevant exec
> > calls that occur in famd, and the only forks() and execs()
> > are to run programs (e.g. "insmod imon").
> 
> You can either a) re-architect the application to use a
> fork/setexeccon/exec model or b) have the application perform access
> checking itself on behalf of the user context via avc_has_perm 

 is there any example code about that does this, or what's the closest
 GPL project that you are aware of that does something with
 avc_has_perm?

 [as you might have noticed cut/paste is my best friend.]

 it will be necessary... eek... to reject even directory accesses
 (opendir) as well.

 hm.

 *thinks*...
 
 ... this is unix.  therefore if you can opendir(), you can at least
 see all the entries.

 ACCESS to the entries is another matter.

 so.

 the question becomes (and assuming that avc_has_perm can do
 directory stuff, which yeh it would be :) is it only necessary
 to do an avc_has_perm on each opendir(), as opposed to doing
 an avc_has_perm on each readdir()?

 or, should i be doing an avc_has_perm( ... READ_PERM ... )
 on every opendir() and then ... say...
 an avc_has_perm ( ... EXECUTE_PERM ... ) on every entry in the
 readdir()?


 or, should i just forget this and live with the terrible but
 serviceable https://listman.redhat.com/archives/fedora-selinux-list/2004-April/msg00297.html

> (but note
> the potential for TOCTTOU issues there, although this may be irrelevant
> for fam as it only monitors files for changes; it doesn't provide access
> to the files themselves).
> 
> Reasons why we don't support a setuid-like operation for security
> contexts have been discussed previously on the list a number of times.  
 
 oh, okie.

 i can't think of any good reasons for a setuid-like operation: however,
 a seteuid-like one i can imagine _some_ reasons, and they all end up
 with the programmer having to remember what's going on, which is Not
 Good.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
