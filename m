Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4F4X1t020983
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 10:04:33 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB4F4WOd010485
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 15:04:32 GMT
Subject: Re: refpolicy HEAD, Debian, ioctl on xconsole by syslogd
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071204111755.GB27359@bobek.pm.i.cz>
References: <20071204111755.GB27359@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 04 Dec 2007 10:04:21 -0500
Message-Id: <1196780661.5854.44.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-04 at 12:17 +0100, Václav Ovsík wrote:
> Hi,
> when starting syslogd by init script:
> 
> audit(1196761642.698:3): avc:  denied { ioctl } for  pid=1353
> comm="syslogd" name="xconsole" dev=tmpfs ino=3703
> scontext=system_u:system_r:syslogd_t:s0
> tcontext=system_u:object_r:xconsole_device_t:s0 tclass=fifo_file 
> 
> attached patch, that xserver_rw_console() gives ioctl permission.
> Can be merged?

I switched it to use rw_fifo_file_perms instead.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
