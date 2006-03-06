Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k26M3RYN013291
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 17:03:27 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k26M1rJj009036
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 22:01:54 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 52133C4C084
	for <selinux@tycho.nsa.gov>; Mon,  6 Mar 2006 23:03:25 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 21655-06 for <selinux@tycho.nsa.gov>;
	Mon, 6 Mar 2006 23:03:24 +0100 (CET)
Received: from wintermute.xmldesign.de (p549A14FC.dip0.t-ipconnect.de [84.154.20.252])
	by legolas.drinsama.de (Postfix) with ESMTP id 47734C4C083
	for <selinux@tycho.nsa.gov>; Mon,  6 Mar 2006 23:03:24 +0100 (CET)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id C41B3234476
	for <selinux@tycho.nsa.gov>; Mon,  6 Mar 2006 23:03:28 +0100 (CET)
Subject: Re: named SELinux policy
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <440C73BA.4050503@redhat.com>
References: <200603061121.49118.jvdias@redhat.com>
	 <440C73BA.4050503@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 23:03:28 +0100
Message-Id: <1141682608.32760.63.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Daniel,
> > The named process does not read any /etc/ files that are not named_conf_t . 
[...]

> > With the next version of bind, I'm going to be replacing the named.conf
> > Provide-d by caching-nameserver with :
> >  $ROOTDIR/etc/named.caching-nameserver.conf , which will include:
> >  $ROOTDIR/etc/named.rfc1912.zones.conf

I consider that seriously broken, btw...

> > And I think we need a better way of labelling named configuration files
> > as named_conf_t rather than just letting named read etc_t* .

We have had a better way for years already...

> I am not a big fan of labeling files in /etc as something other than 
> etc_t.  If these files get created by another tool (sed, emacs, ed, cp, 

I agree for /etc itself. But not for subdirectories.
Use /etc/bind/ please. Like any sane distribution. And then you can
label all the files in that directory the same way.

> File context that differs from parent directory is especially hard to 
> maintain and can give the impression that SELinux is difficult.  We can 

That is why we should make use of directories.

Jason: debian has had /etc/bind/zones.rfc1918 for a long time, why don't
you use this name, too?

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
         Wenn Leute nicht glauben, dass Mathematik einfach ist,        V_/_
              dann nur deshalb, weil sie nicht begreifen,
          wie kompliziert das Leben ist. --- John von Neumann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
