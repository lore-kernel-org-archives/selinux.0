Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8GBjJV7016981
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2012 07:45:23 -0400
Received: from XCH22.scidom.de (xch22.helmholtz-muenchen.de [146.107.8.222])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mta02.helmholtz-muenchen.de (Postfix) with ESMTP id 6AB4C317BD9
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2012 13:42:47 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Sun, 16 Sep 2012 13:45:11 +0200
Subject: RE: ImportError: /usr/lib64/libvirt.so.0: undefined symbol:
 selinux_virtual_domain_context_path
Message-ID: <15785B7E063D464C86DD482FCAE4EBA5017811671EBB@XCH11.scidom.de>
References: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
 <CACLa4ptTg3OsjFyNBbpAi1BVBCKxfVnoYKgGAjLKf8x2pCM2dA@mail.gmail.com>
In-Reply-To: <CACLa4ptTg3OsjFyNBbpAi1BVBCKxfVnoYKgGAjLKf8x2pCM2dA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric wrote:

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Eric Paris
> Sent: Saturday, September 15, 2012 11:24 PM
> To: Lentes, Bernd
> Cc: selinux@tycho.nsa.gov
> Subject: Re: ImportError: /usr/lib64/libvirt.so.0: undefined symbol:
> selinux_virtual_domain_context_path
>
> selinux_virtual_domain_context_path comes from libselinux.  I have no
> idea if the version of libselinux in SLES has the required export.  If
> SLES doesn't have a new enough version of libselinux, then it's a
> libvirt bug that they built with SELinux support on your distro.
>
> So either install libselinux, or file a bug against libvirt if you can't....
>
[]
Hi Eric,

thanks for your answer. How do i know if a version of libselinux hast the required export ?
I installed linux-utils 2.1.9, which include a manpage for  "virtual domain context" (/usr/share/man/man5/virtual_domain_context.5.gz). Is that a hint that this version has the required export ?
Do I need libselinux or libselinux-utils ? I have already installed libselinux1. Is this the same as libselinux ?

Thanks for helping.

Bernd

Helmholtz Zentrum München
Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
Ingolstädter Landstr. 1
85764 Neuherberg
www.helmholtz-muenchen.de
Aufsichtsratsvorsitzende: MinDir´in Bärbel Brumme-Bothe
Geschäftsführer: Prof. Dr. Günther Wess und Dr. Nikolaus Blum
Registergericht: Amtsgericht München HRB 6466
USt-IdNr: DE 129521671


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
