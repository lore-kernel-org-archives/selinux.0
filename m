Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i638jrrT018215
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 04:45:53 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i638jp4K024702
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 08:45:52 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 3 Jul 2004 08:45:46 -0000
Date: Sat, 3 Jul 2004 08:42:42 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kenshi Muto <kmuto@debian.org>
Cc: 254153@bugs.debian.org, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#254153: cupsys: SE/Linux required to give user permission to read /var/spool/cups/certs/0
Message-ID: <20040703084242.GA3099@lkcl.net>
References: <E1BZS5b-0006MZ-FE@lkcl.net> <20040703020944.116BF222FA0@mail.topstudio.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040703020944.116BF222FA0@mail.topstudio.co.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 03, 2004 at 11:09:43AM +0900, Kenshi Muto wrote:
> Hi,
> 
> Sorry for my late response,
> 
> At Sun, 13 Jun 2004 10:19:47 +0000,
> Luke Kenneth Casson Leighton wrote:
> > the permissions on SE/Linux are starting from scratch
> > "everything-is-banned".
> > 
> > therefore, a quite thorough audit is underway as applications are
> > run and users of Debian / SE/Linux find that they "can't do X".
> > 
> > in this instance, "i can't add a printer from KDE's print manager
> > because ordinary users are not given permission to do ANY kind of
> > access to /var/spool/cups."
> > 
> > therefore, please could you consider moving the /var/spool/cups/certs
> > to somewhere more appropriate where ordinary can be given read access
> > to it?
> 
> Hmm, upstream source uses '/etc/cups/certs', but previous cups
> maintainer changed this by:
>   * Moved /etc/cups/certs to /var/spool/cups/certs.  Closes: #144887.
> 
> I don't know what's best location for this cert file, but how about
> '/var/lib/cups/certs'?
 
 given that cups writes to the certs file every 5 mins, as #144887
 says, it's inappropriate for it to be in /etc.

 /var/spool/cups is not accessible except by sysadmin.

 /var/lib/cups can be created and made user-read-accessible so
 that /var/lib/cups/certs can be accessed.

 yep, i reckon that's a more appropriate location.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
