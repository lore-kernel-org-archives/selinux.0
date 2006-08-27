Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7RIaa1a020718
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 14:36:37 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7RIa08S021406
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 18:36:01 GMT
Message-ID: <20060827183635.63375.qmail@web36612.mail.mud.yahoo.com>
Date: Sun, 27 Aug 2006 11:36:35 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: MLS with DAC
To: Salvo Giuffrida <giuffsalvo@hotmail.it>, selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F20E1AAF9368A7EA393C312AF3B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Salvo Giuffrida <giuffsalvo@hotmail.it> wrote:

> Good morning everybody. I wonder if it could be
> possible to achieve partial 
> MLS using standard DAC: what if I create 4 group of
> users (TS, Secret, 
> Confidential, Unclassified), and create documents
> with those groups as 
> owner, so that only users who belong to each group
> can access documents of 
> that kind?

If you turned off multiple groups and
disabled the ability to change mode,
owner, and group attributes on files
and user sessions you could begin to
make an argument that you have MLS.

Alas, your system wouldn't work very well.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
