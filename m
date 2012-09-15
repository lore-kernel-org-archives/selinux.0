Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8FDAPJY012906
	for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2012 09:10:29 -0400
Received: from XCH21.scidom.de (xch21.helmholtz-muenchen.de [146.107.8.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mta01.helmholtz-muenchen.de (Postfix) with ESMTP id 929AB317725
	for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2012 15:08:04 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Sat, 15 Sep 2012 15:10:17 +0200
Subject: ImportError: /usr/lib64/libvirt.so.0: undefined symbol:
 selinux_virtual_domain_context_path
Message-ID: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

i don't know if this is the right place for my question, but i hope. I have a problem which is in my belief related to SELinux.
I try to install the application "virt-manager", which is intendend to be for the control of virtuell domains in KVM.
My box is SLES 11 SP1, 64bit, kernel 2.6.32.
But starting the application throws an error:

pc56846:~ # Traceback (most recent call last):
  File "/usr/share/virt-manager/virt-manager.py", line 26, in <module>
    import libvirt
  File "/usr/lib64/python2.6/site-packages/libvirt.py", line 25, in <module>
    raise lib_e
ImportError: /usr/lib64/libvirt.so.0: undefined symbol: selinux_virtual_domain_context_path

[1]+  Exit 1                  virt-manager
pc56846:~ #

What I found out is that the package "linux-utils", beginning with version 2.1.9, include two manpages having names related to my error:
/usr/share/man/man5/virtual_domain_context.5.gz
/usr/share/man/man5/virtual_image_context.5.gz

I tried to install linux-utils, but didn't find the right version for my box. So I installed the mentioned version, breaking some dependendcies. That didn't help. I don't know if this is not the desired package or if the error is related to the missing dependencies.

Any ideas ?


Bernd

--
Bernd Lentes

Systemadministration
Institut für Entwicklungsgenetik
HelmholtzZentrum münchen
bernd.lentes@helmholtz-muenchen.de
phone: +49 89 3187 1241
fax:   +49 89 3187 3826
http://www.helmholtz-muenchen.de/idg

Wir sollten nicht den Tod fürchten, sondern das schlechte Leben


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
