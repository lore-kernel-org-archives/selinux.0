Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA20824
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:26:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA01925
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 07:25:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA01921
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 07:25:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Policy questions
Date: Sat, 27 Jul 2002 09:25:58 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020727044221.GE18313@snoopy.apana.org.au> <20020727055045.GB20092@snoopy.apana.org.au>
In-Reply-To: <20020727055045.GB20092@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <20020727072558.7D43E1806@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 27 Jul 2002 07:50, Brian May wrote:
> On Sat, Jul 27, 2002 at 02:42:21PM +1000, Brian May wrote:
> > > For clamav.te, I think you should do something similar to what I have
> > > done for the irc domain.  I've partially hacked the appropriate code
> > > into my tree. Doing that will allow multiple user domains easily (the
> > > way you did it will require editing clamav.te every time you add a new
> > > user domain).
> >
> > Good point.
>
> 2nd thoughts, I am not convinced this stuff should go in a macro:
>
> allow user_clamscan_t ttyfile:chr_file rw_file_perms;
> allow user_clamscan_t ptyfile:chr_file rw_file_perms;
> allow user_clamscan_t user_home_t:dir r_dir_perms;
> allow user_clamscan_t user_home_t:file r_file_perms;
> ifdef(`gnome-pty-helper.te', `allow user_clamscan_t gphdomain:fd use;')
>
> As sometime in the future you might want to create
> an domain that can use clamscan that redirects all input to/from
> a GUI (for instance) and doesn't require access to the users
> home directory.

If at some future time you want to create such a domain then you remove the 
macro code.  In the mean time anything that creates a user_foo_t domain MUST 
use a macro, there's no other way for it to work with multiple user domains.

> define(`user_clamscan_domain',`
> clamscan_domain($1)
> allow $1_clamscan_t ttyfile:chr_file rw_file_perms;
> allow $1_clamscan_t ptyfile:chr_file rw_file_perms;
> allow $1_clamscan_t $1_home_t:dir r_dir_perms;
> allow $1_clamscan_t $1_home_t:file r_file_perms;
> ifdef(`gnome-pty-helper.te', `allow $1_clamscan_t gphdomain:fd use;')
> ')

Yes, that's what is needed.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
