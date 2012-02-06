Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q16NmdOr028001
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 18:48:39 -0500
Received: from mail-ee0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q16NmcWx019560
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 23:48:38 GMT
Received: by eeke51 with SMTP id e51so2293341eek.12
        for <selinux@tycho.nsa.gov>; Mon, 06 Feb 2012 15:48:36 -0800 (PST)
Message-ID: <1328572112.1905.10.camel@x220.mydomain.internal>
Subject: Re: SELinux on Wheezy
From: Dominick Grift <dominick.grift@gmail.com>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Tue, 07 Feb 2012 00:48:32 +0100
In-Reply-To: <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328542762.9705.62.camel@moss-pluto>
	 <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Stephen,
> 
> Here are the logs you requested:
> 
> http://www.colliertech.org/federal/nsa/avc-20120206T090101.log

Above logs exposes two bugs in your policy i believe.
Are you using the latest available policy?

possible temporary fixes:

echo "avc:  denied  { associate } for  pid=384 comm="restorecon"
name="shm" dev=devtmpfs ino=5266 scontext=system_u:object_r:tmpfs_t:s0
tcontext=system_u:object_r:device_t:s0 tclass=filesystem" | audit2allow
-M myfs; sudo semodule -i myfs.pp

echo "avc:  denied  { syslog } for  pid=1824 comm="rsyslogd"
capability=34  scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=capability2" | audit2allow
-M mykernel; sudo semodule -i mykernel.pp




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
