Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6DDXNQs023775
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 09:33:41 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6DDXMkr010215
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 13:33:22 GMT
Message-ID: <4E1D9E95.5020206@tresys.com>
Date: Wed, 13 Jul 2011 09:33:09 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
References: <4E1CB8A5.2010707@redhat.com>
In-Reply-To: <4E1CB8A5.2010707@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/12/11 17:12, Daniel J Walsh wrote:
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

Does your suggestion really make it impossible to send a command to
systemd to start/stop a service if you cant read that file (eg
mysqld.service)?  I don't know what the implementation is, but I would
guess that systemctl connects to systemd over a unix socket or fifo to
give commands?  If so, it would seem better for systemd to have some
SELinux awareness on its incoming commands.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
