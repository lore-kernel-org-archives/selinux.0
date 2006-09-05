Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85E0bJd004206
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 10:00:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k85E0FN4010895
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:00:15 GMT
Subject: Re: refpolicy updates from debian
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157399016.4446.20.camel@wintermute.xmldesign.de>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
	 <1157394109.3199.234.camel@sgc>
	 <1157399016.4446.20.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:02:20 -0400
Message-Id: <1157464940.3199.250.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-04 at 21:43 +0200, Erich Schubert wrote:
> > - dropped netuser
> 
> I'm still convinced it's useful.
> It's an easy way of allowing only certain users to setup network
> servers.
> If like, 10% of your users should be allowed to setup network servers,
> the others should not.

I see where it would be useful, I just don't believe its common enough
to be added.

> > - please make a more descriptive name for usbmodules_var_lib_t.  maybe
> > usbmodules_ids_t?
> 
> Right now there is only the usbmodules ids file in there, so that name
> is fine with me. I have no idea if usbmodules might get extra var files
> later on. AFAICT the file is generated from one single source file on my
> system anyway. That might differ for certain USB hardware not supported
> by the stock kernel, though.

After doing a little digging to see where these files are on FC and
Gentoo machines, I see that the existing hwdata_t is the right type for
this.  I have added the appropriate rules and fc entries.  However, I
don't see any options for usbmodules that would have it write to
usb.ids, so why does your patch have this access?

> > - why does system_crond_t connect to mysql?
> 
> I'm not sure, I believe it's cron signaling mysql some maintainance.
> I don't actually use MySQL.
> 
> >From the cronjob:
> # This script only rotates the binary logs. The normal logs are rotated
> # via /etc/logrotate.d/mysql-server.
> 
> I don't know why logrotate is not used for the binary logs, too.

Can you send me a copy of the script off list?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
