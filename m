Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6Q0c2SF024819
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 20:38:02 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6Q0c10D027174
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2008 00:38:01 GMT
Received: by py-out-1112.google.com with SMTP id a78so9651871pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 17:38:01 -0700 (PDT)
Subject: RE: user_identify for httpd (warning: newbie question)
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Murray McAllister <mmcallis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880246B42F@exchange.columbia.tresys.com>
References: <488967D8.1020203@redhat.com> <1216992548.11948.7.camel@sulphur>
	 <6FE441CD9F0C0C479F2D88F959B015880246B42F@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 20:36:11 -0400
Message-Id: <1217032581.14295.4.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-25 at 11:50 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-07-25 at 15:42 +1000, Murray McAllister wrote:
> >> Hi,
> >> 
> >> On Red Hat Enterprise Linux 5 (policy-targeted), I run my main user
> >> account as "user_u:system_r:unconfined_t". When I do a "sudo service
> >> httpd start", httpd runs as "user_u:system_r:httpd_t".
> >> 
> >> On Fedora 9 (policy-targeted), I run my main user account as
> >> "unconfined_u:unconfined_r:unconfined_t". When I do a "sudo service
> >> httpd start", httpd runs as "unconfined_u:system_r:httpd_t".
> >> 
> >> "httpd.conf" is configured on each system to run as the user and
> >> group "apache". 
> >> 
> >> With regards to Fedora 9, am I doing something wrong? Is it okay for
> >> the SELinux user to be "unconfined_u" for services?
> >> 
> >> Thanks for any advice,
> > 
> > It is non-ideal but not a vulnerability (since the TE policy
> > governs what domains can be reached from the service domain, e.g.
> > httpd_t). 
> > 
> > Ideally it would be transitioned to system_u.  Requires
> > SELinux to support automatic user identity transitions,
> > something we didn't expect would be needed since user
> > identity is normally set explicitly by programs.  SELinux has
> > a "run_init" program that will explicitly transition into a
> > system context for restarting system services, but it isn't
> > integrated into /sbin/service and friends - early on in
> > Fedora SELinux integration, they ran into problems with
> > seamlessly making it work with existing usage patterns.
> > 
> > There have been some preliminary patches floated to add user
> > identity transitions to SELinux.  Not sure what the status is
> > on that - Joshua?
> 
> I dropped them when Ubuntu worked around the issue in policy. I can dig
> them out again but I'm not sure its worth bumping the policy version
> just for this and not convinced its entirely necessary anyway.

It has been a long-standing problem with SELinux.  As I said at the
time, I think it is worth adding the user transition support - I just
didn't want to rush the merging of it to suit the Ubuntu schedule.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
