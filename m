Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RICfrT004475
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 14:12:41 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RICBmJ002156
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 18:12:11 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 27 Jul 2004 18:12:35 -0000
Date: Tue, 27 Jul 2004 19:23:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040727182340.GW3392@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <1090949595.2448.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090949595.2448.180.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 27, 2004 at 01:33:15PM -0400, Stephen Smalley wrote:
> On Tue, 2004-07-27 at 12:06, Luke Kenneth Casson Leighton wrote:
> >  well, not entirely - not dynamically, anyway: at least i do not
> >  believe so.
> > 
> >  i thought originally that it would be possible to do what i envisaged
> >  with m4, by extending the policy language.
> 
> There are already plenty of cases where derived domains are defined via
> macros, so that the new domain expresses information about both the
> caller and the newly executed program.  Even in your example, kde_user_t
> is an example of a derived domain that can implicitly indicate that the
> caller was user_t, without needing multiple contexts at all.
 
 ah ha!

 okay.

 perhaps this will make it clearer.

 is it possible to write, in macro form, a policy which will allow
 only a subset of KDE programs to be run...

 ... _without_ affecting, changing or impacting the existing policies
 under which user_t runs kde programs, and preferably _without_ having
 to copy a stack-load of things from user_t to [the proposed]
 kde_user_t.

 you see, at present, what i would do is:

 - define a user type kde_user_t

 - make startkde transition to kde_user_t

 - define one policy per kde program.
 
 - start running programs, running audit2allow whenever something
   broke, and add the permissions to the relevant program's policy.


 now, whilst this is possibly the best (paranoid) way to do it
 (you get to vet the functionality of every KDE program under
 the sun), this ain't too _intelligent_ a way to do it :)

 what i would _prefer_ to do is to "jump" into user_t context ....
 but only for certain programs.


 okay.  i know a good way to describe it.

 under POSIX, i would just create a group kdeprogs, make the users
 a member of that group, allow execute permission to certain kde
 programs for group kdeprogs, chgrp the programs to that group, and
 be done with it, making sure to take extra care of root-setuid
 programs.

 hey, i might end up doing that after all.

 but i would _prefer_ it if i could somehow do the same thing using
 SE/Linux.

 and that "multiple contexts" idea was one way i thought that might
 be achievable.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
