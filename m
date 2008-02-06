MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Resend: Sudo Changes for SELinux
Date: Wed, 6 Feb 2008 09:59:41 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181F138@exchange.columbia.tresys.com>
In-Reply-To: <47A08F44.20308@redhat.com>
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Stefan Schulze Frielinghaus" <stefan@seekline.net>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any reason sesh needs to fork()?  If all you need is an
exec-time transition isn't it sufficient to just call exec()?

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
