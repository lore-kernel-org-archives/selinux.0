Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8FLNue7030899
	for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2012 17:23:56 -0400
Received: by wibhq4 with SMTP id hq4so945014wib.12
        for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2012 14:23:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
References: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
Date: Sat, 15 Sep 2012 17:23:54 -0400
Message-ID: <CACLa4ptTg3OsjFyNBbpAi1BVBCKxfVnoYKgGAjLKf8x2pCM2dA@mail.gmail.com>
Subject: Re: ImportError: /usr/lib64/libvirt.so.0: undefined symbol: selinux_virtual_domain_context_path
From: Eric Paris <eparis@parisplace.org>
To: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux_virtual_domain_context_path comes from libselinux.  I have no
idea if the version of libselinux in SLES has the required export.  If
SLES doesn't have a new enough version of libselinux, then it's a
libvirt bug that they built with SELinux support on your distro.

So either install libselinux, or file a bug against libvirt if you can't....


On Sat, Sep 15, 2012 at 9:10 AM, Lentes, Bernd
<bernd.lentes@helmholtz-muenchen.de> wrote:
> Hi,
>
> i don't know if this is the right place for my question, but i hope. I have a problem which is in my belief related to SELinux.
> I try to install the application "virt-manager", which is intendend to be for the control of virtuell domains in KVM.
> My box is SLES 11 SP1, 64bit, kernel 2.6.32.
> But starting the application throws an error:
>
> pc56846:~ # Traceback (most recent call last):
>   File "/usr/share/virt-manager/virt-manager.py", line 26, in <module>
>     import libvirt
>   File "/usr/lib64/python2.6/site-packages/libvirt.py", line 25, in <module>
>     raise lib_e
> ImportError: /usr/lib64/libvirt.so.0: undefined symbol: selinux_virtual_domain_context_path
>
> [1]+  Exit 1                  virt-manager
> pc56846:~ #
>
> What I found out is that the package "linux-utils", beginning with version 2.1.9, include two manpages having names related to my error:
> /usr/share/man/man5/virtual_domain_context.5.gz
> /usr/share/man/man5/virtual_image_context.5.gz
>
> I tried to install linux-utils, but didn't find the right version for my box. So I installed the mentioned version, breaking some dependendcies. That didn't help. I don't know if this is not the desired package or if the error is related to the missing dependencies.
>
> Any ideas ?
>
>
> Bernd
>
> --
> Bernd Lentes
>
> Systemadministration
> Institut für Entwicklungsgenetik
> HelmholtzZentrum münchen
> bernd.lentes@helmholtz-muenchen.de
> phone: +49 89 3187 1241
> fax:   +49 89 3187 3826
> http://www.helmholtz-muenchen.de/idg
>
> Wir sollten nicht den Tod fürchten, sondern das schlechte Leben
>
>
> Helmholtz Zentrum München
> Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
> Ingolstädter Landstr. 1
> 85764 Neuherberg
> www.helmholtz-muenchen.de
> Aufsichtsratsvorsitzende: MinDir´in Bärbel Brumme-Bothe
> Geschäftsführer: Prof. Dr. Günther Wess und Dr. Nikolaus Blum
> Registergericht: Amtsgericht München HRB 6466
> USt-IdNr: DE 129521671
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
