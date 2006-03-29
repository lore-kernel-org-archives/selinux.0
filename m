Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2TNiSYv014277
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 18:44:28 -0500
Received: from zproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2TNiQ77000257
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 23:44:27 GMT
Received: by zproxy.gmail.com with SMTP id x3so282910nzd
        for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 15:44:27 -0800 (PST)
Message-ID: <80d7e4090603291544m3096f484he2c4552cd6ec66a8@mail.gmail.com>
Date: Wed, 29 Mar 2006 16:44:27 -0700
From: "Stephen J. Smoogen" <smooge@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: Need testers for Modules policicy on RHEL4
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
In-Reply-To: <442B182D.9060104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <442B182D.9060104@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/29/06, Daniel J Walsh <dwalsh@redhat.com> wrote:
> I have back ported the entire selinux tool chain to RHEL4.  I have also
> attempted to create a modular policy to match RHEL4 policy as closely as
> possible.
>
> These packages are out on
>
> ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR
>
> If anyone wants to play with these and do some testing that would be great.

Cool. I realize there is no promise but I will try them on a test box.
What should I look for in a test plan? Also what is the difference
between selinux-policy-2.2.28-1.rhel4.noarch.rpm and
selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm?


>
> There is no commitment from Red Hat to ever ship this.  But if it is
> ever going to ship,
> we need to find problems with it now.
>
> So if you have a spare RHEL4 box and want to play with modular policy,
> this is your chance.
>
> Thanks,
>
>
> Dan
>
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>


--
Stephen J Smoogen.
CSIRT/Linux System Administrator


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
