Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2UKx9dn002663
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 15:59:09 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2UKx4c9000739
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 20:59:06 GMT
Subject: Re: Need testers for Modules policicy on RHEL4
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Stephen J. Smoogen" <smooge@gmail.com>,
        "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442C38CD.2000305@redhat.com>
References: <442B182D.9060104@redhat.com>
	 <80d7e4090603291544m3096f484he2c4552cd6ec66a8@mail.gmail.com>
	 <442C38CD.2000305@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 15:59:16 -0500
Message-Id: <1143752356.13732.63.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 15:00 -0500, Daniel J Walsh wrote:
> Stephen J. Smoogen wrote:
> > On 3/29/06, Daniel J Walsh <dwalsh@redhat.com> wrote:   
> >> I have back ported the entire selinux tool chain to RHEL4.  I have also
> >> attempted to create a modular policy to match RHEL4 policy as closely as
> >> possible.
> >>
> >> These packages are out on
> >>
> >> ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR
> >>
> >> If anyone wants to play with these and do some testing that would be great.
> >
> > Cool. I realize there is no promise but I will try them on a test box.
> > What should I look for in a test plan? Also what is the difference
> > between selinux-policy-2.2.28-1.rhel4.noarch.rpm and
> > selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm?
> >
> >   
> Look for regressions.  Want to make sure RHEL4 works the same under 
> both.  The new policy has some added allows but should not have any ones 
> missing.  There are some types that have been eliminated but they were 
> not used.

One known thing would be the missing su(do)+pam_login rules.  I plan on
making a rhel4 distro tunable (which infers the redhat tunable too), to
handle things that are in RHEL4, but no longer in newer Red Hat
releases.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
