Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HFdoEn006409
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 11:39:50 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5HFdnd5000491
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 15:39:50 GMT
Subject: Re: gnome-screensav AVCs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 11:39:10 -0400
Message-Id: <1213717150.11146.88.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
> I'm seeing AVCs related to netlink_audit_socket when the screen saver
> dialog is run. gnome-screensaver-dialog opens a pam session which uses
> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
> gnome-screensaver-dialog is going to need some policy including
> possibly authlogin_common_auth_domain_template.

I'm not 100% clear, is the auditing happening from unix_chkpwd or the
screensaver proper?

> Would it be best to add policy for this to gnome or should it have
> it's own module?

The gnome module is for policies for core gnome components.
Unfortunately "core component" isn't really well defined at the moment.
But I've been thinking about it since Dan has a gnome clock applet
policy since it can set the clock.  If we had a better idea what pieces
needed their own domain, it'd be easier to make a decision.  Something
like dbus doesn't fit since its useful outside of gnome.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
