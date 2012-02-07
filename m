Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q17IiuSS022999
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 13:44:56 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q17Iit5X029586
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 18:44:55 GMT
Received: by eaad1 with SMTP id d1so1003218eaa.12
        for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2012 10:44:55 -0800 (PST)
Message-ID: <1328640292.1905.13.camel@x220.mydomain.internal>
Subject: Re: SELinux on Wheezy
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Tue, 07 Feb 2012 19:44:52 +0100
In-Reply-To: <1328636556.2162.59.camel@moss-pluto>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328542762.9705.62.camel@moss-pluto>
	 <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636556.2162.59.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-07 at 12:42 -0500, Stephen Smalley wrote:

> 
> The avc message suggests that your processes are not running in the
> right domains, which in turn suggests that perhaps your filesystems are
> not correctly labeled.  sestatus -v should provide more information.
> 

whoops yes i agree there. rsyslogd runs in the kernel_t domain.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
