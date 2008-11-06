Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6GjVnL031267
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 11:45:31 -0500
Received: from mail.magitekltd.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6GjUEm021617
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 16:45:30 GMT
Subject: Re: restorecon / matchpathcon
From: LC Bruzenak <lenny@MagitekLtd.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <49131CD7.7070204@redhat.com>
References: <1225987455.7321.37.camel@homeserver>
	 <49131CD7.7070204@redhat.com>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 10:45:29 -0600
Message-Id: <1225989929.7321.39.camel@homeserver>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-11-06 at 11:35 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> LC Bruzenak wrote:
> > I see no way to recursively/silently check path context.
> > 
> > The matchpathcon command has a silent but no recursive option. It does
> > return non-zero if something doesn't match.
> > 
> > The restorecon command has both recursive and don't change options but
> > no silent. It does not return non-zero if there is a change to be made,
> > so a redirect of stdout to /dev/null wouldn't suffice.
> > 
> > Is there another way/command?
> > 
> > Thx,
> > LCB.
> > 
> find | xargs matchpathcon?

I think in this case the $? return value would refer to the find not
matchpathcon right?

LCB.

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
