Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72GAPrT013884
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:10:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72GAMKV016798
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 16:10:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: /etc/qt3/.qt*
Date: Tue, 3 Aug 2004 02:10:20 +1000
Cc: Erich Schubert <erich@debian.org>, SE-Linux <selinux@tycho.nsa.gov>
References: <20040801194006.GF20103@lkcl.net> <1091391553.7861.17.camel@wintermute.xmldesign.de> <20040802144542.GC4194@lkcl.net>
In-Reply-To: <20040802144542.GC4194@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408030210.20528.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Aug 2004 00:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > I don't have a /etc/qt3. And if i had it, it certainly would be mode
> > 0755, so no user can write there (and i don't think running qt apps as
> > root is a good idea) - something must be wrong with your setup.
>
>  this is very strange.
>
>  it's kde 3.2.2, bog-standard.
>
>  and it's root that's trying to write there (xdm_t and xdm_server_t).

xdm_t is for kdm as I previously mentioned.

Is xdm_xserver_t (the X server domain) REALLY trying to write to those files?  
Or is it just inheriting open file handles from kdm?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
