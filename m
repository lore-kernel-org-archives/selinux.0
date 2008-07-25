Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PDV64m019483
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 09:31:06 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PDV5n9018331
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 13:31:05 GMT
Received: by py-out-1112.google.com with SMTP id a78so8886583pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 06:31:05 -0700 (PDT)
Subject: Re: user_identify for httpd (warning: newbie question)
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <488967D8.1020203@redhat.com>
References: <488967D8.1020203@redhat.com>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 09:28:55 -0400
Message-Id: <1216992548.11948.7.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-25 at 15:42 +1000, Murray McAllister wrote:
> Hi,
> 
> On Red Hat Enterprise Linux 5 (policy-targeted), I run my main user 
> account as "user_u:system_r:unconfined_t". When I do a "sudo service 
> httpd start", httpd runs as "user_u:system_r:httpd_t".
> 
> On Fedora 9 (policy-targeted), I run my main user account as 
> "unconfined_u:unconfined_r:unconfined_t". When I do a "sudo service 
> httpd start", httpd runs as "unconfined_u:system_r:httpd_t".
> 
> "httpd.conf" is configured on each system to run as the user and group 
> "apache".
> 
> With regards to Fedora 9, am I doing something wrong? Is it okay for the 
> SELinux user to be "unconfined_u" for services?
> 
> Thanks for any advice,

It is non-ideal but not a vulnerability (since the TE policy governs
what domains can be reached from the service domain, e.g. httpd_t).

Ideally it would be transitioned to system_u.  Requires SELinux to
support automatic user identity transitions, something we didn't expect
would be needed since user identity is normally set explicitly by
programs.  SELinux has a "run_init" program that will explicitly
transition into a system context for restarting system services, but it
isn't integrated into /sbin/service and friends - early on in Fedora
SELinux integration, they ran into problems with seamlessly making it
work with existing usage patterns.

There have been some preliminary patches floated to add user identity
transitions to SELinux.  Not sure what the status is on that - Joshua?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
