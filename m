Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04052
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 09:57:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA29404
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:55:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA29400 for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:55:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>,
        Samarth Sharma <samarth7880@rediffmail.com>
Subject: Re: policy for new user?
Date: Thu, 8 Aug 2002 15:57:12 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0208080908370.9323-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0208080908370.9323-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <20020808135712.A0CB320B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Aug 2002 15:23, Wayne Salamon wrote:
> > 1>i added a new user with sysadm_r role.however this user was not
> > able to run the program "adduser" .. eventhough this user has
> > sysadm role.
>
>   'adduser' still needs to run as the root user because normal permissions
> are still enforced by the kernel.
>
> > 2>how do you create a file with system_u identity?
>
>   There are several ways to change the context on a file.
>
>   1) Use the 'chsid' program.

Or "chcon".  I think that in a "default" install (apart from a Debian 
install) you'll have "chcon" but not "chsid".

Also note that chsid can't change the type of a link, you need "chcon -h".
I'm thinking of using the "alternatives" mechanism in Debian cause chcon to 
be used if present instead of chsid because of this.  Or I may just improve 
chsid.  I really stuffed one machine by using chsid in a chroot in permissive 
mode (which followed absolute symlinks)...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
