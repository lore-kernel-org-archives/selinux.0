Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATDfQRb000339
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 08:41:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATDfPqY025346
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 13:41:25 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hATDfN0o025343 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 13:41:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Petre Rodan <petre.rodan@ravantivirus.com>
Subject: Re: policies for DJ Bernstein tools
Date: Sun, 30 Nov 2003 00:41:15 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20031128164612.GA32668@peter.rav.local> <200311292147.58963.russell@coker.com.au> <20031129132111.GA22741@peter.rav.local>
In-Reply-To: <20031129132111.GA22741@peter.rav.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311300041.15386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 30 Nov 2003 00:21, Petre Rodan <petre.rodan@ravantivirus.com> wrote:
> > I have added your changes to qmail.te and qmail.fc to my tree, it'll be
> > on my site in a few minutes.  I have modified them slightly so you will
> > want to check that they still do what you require.  I removed the
> > user_home_t label for the qmail alias directory as I don't think that's
> > an appropriate type. Maybe etc_qmail_t will work.
>
> acording to Dave Sill's 'life with qmail' install guide (the best one out
> there) alias is a pseudo-user that gets the mails that did not have a valid
> recipient on the server. I gave him a user_home_t so he gets mail without
> other modifications done to qmail_local_t.

This will require more investigation.  However ~alias is different from a 
regular user home directory, and it seems unlikely that you would want user_r 
to write to it.  So therefore user_home_t seems like the wrong type for it.

We could create a new qmail_home_t type which has attributes home_type and 
user_home_type to allow qmail to access it.

> > What is clockspeed?
>
> it's a SNTP client available here:
> http://cr.yp.to/clockspeed.html
>
> the big difference between clockspeed and ntpd is the number of exploits
> ...

So why not have clockspeed run in ntpd_t?

> I understand, I will definitely rewrite that part somehow.
> The reason I made this context is because I have a lot of scripts (eighter
> run through ssh or by crond_t) that send mail with attachments using mutt.

Doesn't mutt just run "sendmail -t"?  If not why not?  If so then why doesn't 
it get staff_mail_t for the sendmail process?

> you use the cvs.sourceforge.net:/cvsroot/selinux repository?
> just to make sure we use the same source ...

I maintain my own policy tree based on the NSA release plus all patches that 
flow through this list and other sources.  It often varies significantly from 
the CVS, but at the moment there is not much difference.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
