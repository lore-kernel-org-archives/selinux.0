Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1N6nudW028417
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 01:49:56 -0500 (EST)
Received: from mail02.infosat.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1N6j6rg004951
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 06:45:10 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 208199205 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 08:47:13 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 646271087 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 08:47:12 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Wed, 23 Feb 2005 08:45:41 +0200
References: <200502220809.40631.jayendren@hivsa.com> <1109077449.2256.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1109077449.2256.9.camel@moss-spartans.epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502230845.41243.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 15:04, you wrote:
thanks!
i shall stop bothering u guys!

God bless.

> On Tue, 2005-02-22 at 08:09 +0200, Jayendren Anand Maduray wrote:
> > Got FC3 running SELINUX in enforcing mode.
> >
> > 1. however when i try to change my password, i get the ffg error:
> > SystemError: couldn't get security context of `/etc/passwd': No data
> > available
> >
> > 2. also, when i boot up, syslogd, and portmap cannot start, so i disabled
> > it in SELinux. i would like to get this to work, though.
> >
> > i am running kernel Linux shiva 2.6.10-1.741_FC3smp
>
> The most likely scenario is that you never labeled your filesystems, or
> that you ran with SELinux disabled for some period of time and thus
> ended up with some files without security labels.  Touch /.autorelabel
> and reboot, or run /sbin/fixfiles relabel and reboot.  BTW, this kind of
> question belongs on fedora-selinux-list, not here, IMHO.

-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator  

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
