Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0E8cfRb024521
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 03:38:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0E8bWxr017427
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 08:37:32 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id i0E8bVYc017424
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 08:37:32 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 4472119E3932
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 09:38:01 +0100 (CET)
Date: Wed, 14 Jan 2004 09:38:00 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: [patch] Change libselinux to use getpwnam_r
Message-ID: <20040114083800.GA7603@suse.de>
References: <1074008488.13586.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1074008488.13586.20.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 13, Stephen Smalley wrote:

> The attached patch against libselinux-1.4 changes it to use getpwnam_r
> internally instead of getpwnam, so that it doesn't clobber any existing
> pwd struct previously obtained by the caller.  This showed up as an
> issue for the selinux-enabled gdm.  It doesn't appear to affect login or
> sshd, since they make a copy of the pwd struct themselves.

> +       buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +       if (buflen < 0)
> +               return -1;
> +       buf = malloc(buflen);
> +       if (!buf)
> +               return -1;
> +       retval = getpwnam_r (user, pwd, buf, buflen, &pwd );
> +        if (retval < 0 || !pwd) {
> +               free(buf);
> +               return -1;
>          }

While _SC_GETPW_R_SIZE_MAX should return the max. size getpwnam_r
needs for a buffer, in reallity this is often not enough. There is
no limit, how long a line in /etc/passwd can be.
So a better way is:

while (getpwnam_r (user, pwd, buf, buflen, &pwd) != 0
         && errno == ERANGE)
    {
      errno = 0;
      buflen *= 2;
      buf = realloc (buf, buflen);
    }


 Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Maxfeldstr. 5                 D-90409 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
