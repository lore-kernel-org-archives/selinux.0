Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4P8flRb016260
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 04:41:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4P8d2ar024957
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 08:39:02 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
	by jazzswing.ncsc.mil  with SMTP id i4P8d1Qu024954
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 08:39:01 GMT
Date: Tue, 25 May 2004 08:37:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Timothy <timothy@diyab.net>, Russell Coker <russell@coker.com.au>,
   Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
Subject: Re: [PATCH][RFC] Allow administrator control over per-user default_contexts
Message-ID: <20040525083744.GB3264@lkcl.net>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil> <200405240612.15645.russell@coker.com.au> <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil> <200405241004.07827.timothy@diyab.net> <1085408849.26446.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085408849.26446.98.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

uhm, not being funny or anything but is there a simpler approach
to all this?

might i make a suggestion based on what i know of NT security
descriptors (formerly known as VAX/VMS security before dave cutler
went to work for microsoft it's a long story :)

NT security descriptors are not 32-bits but can vary between
about 5 bytes and approx 16.  they consist of a prefix which
is the domain and the very last word (suffix) represents a
user or a group.  btw i am very surprised that the opportunity
to extend the size of security descriptors to a world-size
view (i.e. outside of a single machine) i.e. beyond 32-bit
and to 128-bit or more.  but i digress.

in NT 4.0 SD model, the concept of "local groups" was introduced
but for NT 5.0 (aka 2000) the distinction was removed at the
risk of also introducing circular group membership dependencies.

the important bit that i wanted to mention to you is that in
the NT security model GROUPS can own objects (files, processes
etc).

this is distinctly different from unix, whereby only users can
own files (and it causes a lot of problems for anyone implementing
an SMB server if they choose to map direct to any kind of
unix file system rather than provide their own)
 

groups being able to own objects means greatly simplified management.

so, what i was wondering: is there a similar such concept in
SE/Linux, with domains?


On Mon, May 24, 2004 at 10:27:29AM -0400, Stephen Smalley wrote:
> On Mon, 2004-05-24 at 10:04, Timothy wrote:
> > How about check for /etc/security/default_contexts.user/username and if it 
> > exists, ignore $HOME/.default_contexts.  Next 
> > check /etc/security/default_contexts.user/username for a valid context that 
> > is allowed by policy and if it does exist, then use that.  Otherwise use the 
> > system default. Then if an administrator wants to disable user set contexts 
> > an not set a specific one he can just create an empty file for that username 
> > in the /etc/security/default_contexts.user directory and no extra file would 
> > be needed.
> 
> The logic already allows for leaving the per-user default_contexts file
> empty or incomplete; it always pulls the context lists from both the
> per-user default_contexts file and the system default_contets file (with
> the latter given lower precedence) and omits any contexts that would be
> invalid for the user or unreachable from the calling context.  But the
> approach you suggest still requires the admin to at least create an
> empty file for every user account simply to disable use of
> $HOME/.default_contexts, which is burdensome and error-prone if the
> admin simply wants to disallow all use of $HOME/.default_contexts.  I
> think we want a simple mechanism for the admin to express that goal
> without needing to maintain per-user files at all, even empty ones.
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
