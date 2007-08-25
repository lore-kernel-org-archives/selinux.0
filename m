Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7PAW0XO003505
	for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2007 06:32:00 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7PAVxDF008645
	for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2007 10:31:59 GMT
Message-ID: <46D00510.80608@redhat.com>
Date: Sat, 25 Aug 2007 06:31:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Devin Carraway <selinux-list@devin.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [refpolicy] policy & patch for bitlbee
References: <20070819045707.GJ18641@atlantic.devin.com>
In-Reply-To: <20070819045707.GJ18641@atlantic.devin.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Devin Carraway wrote:
> Here's a policy module for BitlBee, a service which acts as a gateway for IRC
> clients to various IM networks.
> 
> The patch adds three new ports to the corenetwork list, for the AIM, Yahoo
> Messenger and MSN Messenger ports.  I drew the port names from the IANA
> "registered por numbers' list at http://www.iana.org/assignments/port-numbers .
> 
> It's my first attempt at writing a policy module clean enough for publication;
> feedback/criticism would be welcome.
> 
> Devin
> 
> 
Sorry I am way behind on selinux list.

First comment, if you have files directories that the confined domain
does not need to write, and the data within is not secret,  IE You dont
want other domains to be able to read it.  DO NOT create a type.  Just
leave the files the default type, and use the interface to allow you
domain to read it.

So I would remove


type bitlbee_conf_t;
files_config_file(bitlbee_conf_t)

type bitlbee_share_t;
files_type(bitlbee_share_t)

And just allow bitlbee to read etc_t and usr_t.

Everything else looks ok.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG0AUQrlYvE4MpobMRAm8xAKDjeSySjEY+64bmgNBkEwQ/H9SE+wCggt4A
zUWWi8GzT4O0o2t7tgg1Cwc=
=eQ+k
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
