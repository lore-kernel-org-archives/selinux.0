Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8GE5fT7022262
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2012 10:05:41 -0400
Received: by wgbdt14 with SMTP id dt14so626146wgb.30
        for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2012 07:05:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <15785B7E063D464C86DD482FCAE4EBA5017811671EBB@XCH11.scidom.de>
References: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
	<CACLa4ptTg3OsjFyNBbpAi1BVBCKxfVnoYKgGAjLKf8x2pCM2dA@mail.gmail.com>
	<15785B7E063D464C86DD482FCAE4EBA5017811671EBB@XCH11.scidom.de>
Date: Sun, 16 Sep 2012 10:05:09 -0400
Message-ID: <CACLa4puiBuWqK6C-gFJckMibx+rsRruchAsc0Fygu1qS5Qt3Hw@mail.gmail.com>
Subject: Re: ImportError: /usr/lib64/libvirt.so.0: undefined symbol: selinux_virtual_domain_context_path
From: Eric Paris <eparis@parisplace.org>
To: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 16, 2012 at 7:45 AM, Lentes, Bernd
<bernd.lentes@helmholtz-muenchen.de> wrote:

> thanks for your answer. How do i know if a version of libselinux hast the required export ?
> I installed linux-utils 2.1.9, which include a manpage for  "virtual domain context" (/usr/share/man/man5/virtual_domain_context.5.gz). Is that a hint that this version has the required export ?
> Do I need libselinux or libselinux-utils ? I have already installed libselinux1. Is this the same as libselinux ?

Lets start by saying again, I don't know anything about how SUSE
packages stuff.  But, libselinux is going to be the package that
provides /usr/lib(64)/libselinux.so.1.  You should be able to run
something like:

$ nm /usr/lib64/libselinux.so.1 -D | grep selinux_virtual_domain_context_path

If you get output, then your library is new enough.  My output looked like:

00000038cbe16fe0 T selinux_virtual_domain_context_path

I don't know why the man page is a part of linux-utils.  That's not
how other distros ship it, but I can promise, "linux-utils" is a red
herring.  The problem is that the version of libvirt you are using
requires a version of libselinux which includes
selinux_virtual_domain_context_path.  Getting a new enough version of
libselinux installed or getting a version of libvirt which doesn't
require SELinux is going to be how you get this fixed.  It might be
best to bring your problem to your SUSE technical support
representative, since I don't anything about how they package things
and I don't hear from a lot of SELinux users on SLES on list...

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
