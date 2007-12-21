Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLFPM13026264
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 10:25:22 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLFPKp9016427
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 15:25:21 GMT
Subject: Re: [DSE-Dev] refpolicy HEAD, Debian, ioctl on xconsole by syslogd
From: Erich Schubert <erich@debian.org>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071221143103.GA1335@bobek.pm.i.cz>
References: <20071204111755.GB27359@bobek.pm.i.cz>
	 <1196780661.5854.44.camel@gorn> <20071214115153.GA21605@bobek.pm.i.cz>
	 <1197901948.12626.244.camel@gorn>  <20071221143103.GA1335@bobek.pm.i.cz>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 16:25:09 +0100
Message-Id: <1198250709.3846.24.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'm still convinced of the opinion that /dev/xconsole has nothing to do
with the Xserver or devices. It's just a logging pipe, and that is
exactly where it should go to: the logging module.
The only thing I'm aware of linking xconsole with the Xserver is that
the xconsole program is one of a couple of utilities usually included
with the xserver...

>From the xconsole man page:
DESCRIPTION
The xconsole program displays messages which are usually sent to /dev/console.

Note that /dev/console has nothing to do with the xserver either. This
is not about seeing Xserver output. It's about seeing system console
output (which happens to be handled by system logging these days...)

Also note that IIRC the only thing that actually could write
to /dev/xconsole on SELinux is syslog, isn't it? The X server can not?

> What about to rename xconsole_device_t to xconsole_pipe_t?

Or logging_xconsole_pipe_t or so. Although something similar to the type
of /dev/console would be appropriate, I guess.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
    Der Anfang aller Erkenntnis ist das Staunen. --- Aristoteles    V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
