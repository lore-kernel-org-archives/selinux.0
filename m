Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07322
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:57:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA26303
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:55:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA26299 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:55:33 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: type_change rules
Date: Mon, 19 Aug 2002 14:57:00 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208190841390.14458-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208190841390.14458-100000@raven>
MIME-Version: 1.0
Message-Id: <20020819125700.7B617531@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 14:46, Stephen Smalley wrote:
> On Sun, 18 Aug 2002, Russell Coker wrote:
> > In macros/user.te we have the following line:
> > type_change $1_t tty_device_t:chr_file $1_tty_device_t;
> >
> > However the tty label seems to be that which matches the last usesr
> > logged in (a security issue in itself).
>
> login should reset the tty label back to the original type when the user
> logs out.  However, if login doesn't exit properly, then it will be left
> in the type.

In my case it appears that login exec's the user's shell and is gone from 
memory.

So it seems that to get this working correctly I need some changes to the 
login program to make it hang around (as login programs apparently do in 
other distributions), and I need to make sure that the SAK is blocked from 
killing the login process.

> In this case, the tty will be correctly updated on the next
> login due to the type_change rules in newrole.te for dealing with the
> similar issue when newrole is terminated abruptly.  The real fix is to
> have the rc scripts or getty reset the types properly.

rc scripts aren't involved.  Doing it in init is ugly.  Changing getty means 
changing 4 getty programs that I use on machines I run (and more getty 
programs for a comprehensive solution).  I don't think that this is the real 
fix.

I could write a getty wrapper which just does fork()/exec()/wait() and then 
changes the specified device back to it's original SID after the wait() 
returns.  As the wrapper would NEVER open the terminal in question it wold 
escape the SAK.  This might be the best solution, although if there are other 
benefits to having /bin/login keep running then that might be the option.

> > However it also has the issue that when you create a new user role you
> > must also create matching type_change rules to allow changes from all
> > other user domains (IE the number of rules is proportional to the number
> > of user domains squared).  Is there any reason for not doing the
> > following?
> > type_change $1_t ttyfile:chr_file $1_tty_device_t;
>
> Aside from the state explosion in the TE rules, no.  But the better
> solution would be to have the rc scripts or getty reset the type properly
> to avoid the need for these rules.

I think getting login to do it would be best.  Or if not login then have a 
getty wrapper program do it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
