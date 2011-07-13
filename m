Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6DHbxEr029087
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 13:38:04 -0400
Received: from phoenicia.airattack-central.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6DHbgj9005218
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 17:37:43 GMT
Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
From: Matthew Ife <deleriux@airattack-central.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 13 Jul 2011 18:20:31 +0100
In-Reply-To: <4E1CB8A5.2010707@redhat.com>
References: <4E1CB8A5.2010707@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310577633.19434.6.camel@home.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I dont think that will work. According to my strace systemd performs the
work completely on behalf of the user when calling systemctl.

It might be more elegant to solve the problem in software.. ideally with
some selinux object manager for systemd that systemctl can be
intercepted with.

Say classes of target and service and permissions like start, stop
reload, restart etc.

That could take a while to implement though.

On Tue, 2011-07-12 at 17:12 -0400, Daniel J Walsh wrote:
> Currently we can setup certain domains to be allowed to execute labeled
> init scripts.  If we go away from init scripts we will need a mechanism
> for init to look at the calling program label to figure out if it is
> allowed to start/stop certain domains.
> 
> Can webadm_t start/stop mysqld_t?  Can webadm_t start/stop httpd_t?
> 
> # id -Z
> staff_u:webadm_r:webadm_t:s0-s0:c0.c1023
> # systemctl start httpd.service
> # systemctl stop httpd.service
> 
> Another option would be just whether label
> /lib/systemd/system/mysqld.service something that webadm_t is not
> allowed to read.
> 
> Ideas?
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
