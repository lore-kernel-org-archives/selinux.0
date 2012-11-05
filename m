Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA5HfumF032229
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2012 12:42:01 -0500
Received: by mail-wi0-f177.google.com with SMTP id hj13so2405918wib.12
        for <selinux@tycho.nsa.gov>; Mon, 05 Nov 2012 09:41:29 -0800 (PST)
Message-ID: <1352137286.2345.10.camel@d30.localdomain>
Subject: Re: With systemd taking care of starting services, is there any
 reason to continue to ship run_init?
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 05 Nov 2012 18:41:26 +0100
In-Reply-To: <5097EE9C.6020104@redhat.com>
References: <5097EE9C.6020104@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Mon, 2012-11-05 at 11:51 -0500, Daniel J Walsh wrote:
> systemctl start SERVICE
> 
> Will start the service cleanly as the correct context, I want to remove this
> command from systemd enabled systems.  Any one know of a reason to not do this?
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Keep in mind that run_init is also used in other scenarios

for example:

newaliases
rpm/yum

If you have ubac enabled and you run yum install app without run_init as
sysadm_t then some of the installed files might end up with a identity
that ubac constrained domains might not be allowed to access and that
might break functionality.

Also keep in mind that upstart is still available in the repository and
people might decide to use that instead of systemd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
