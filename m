Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06936
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 11:04:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA27727
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:04:20 GMT
Received: from [170.51.186.96] (cti015035.prima.com.ar [200.42.15.35])
	by jazzband.ncsc.mil  with ESMTP id QAA27723
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:04:14 GMT
Received: from mail.cti.com.ar (unverified) by
 (Content Technologies SMTPRS 4.2.1) with SMTP id <T57187a99feaa33ba6063c@> for <selinux@tycho.nsa.gov>;
 Thu, 8 Nov 2001 13:07:22 -0300
Received: from cti.com.ar (radon.cti [10.92.20.69])
	by ctinet.com.ar (8.8.6 (PHNE_17190)/8.8.6) with ESMTP id NAA23916
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 13:04:41 -0300 (SAT)
Message-ID: <3BEAF3B5.3EF2777A@cti.com.ar>
Date: Thu, 08 Nov 2001 13:05:57 -0800
From: "Hugo F. Martinez" <hmartinez@cti.com.ar>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: How can i configure this?
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello:
    I've just have installed  selinux on my notebook to test it and
implement it on several servers if all my test works, and for acomplish
my tests in need your help if you can. On my new flask-kernel I've got
several messages from the AVC reporting that an action is denied. For
example i got the following when starting my pcmcia services:

Nov  8 09:06:46 radon-ntb kernel: Linux PCMCIA Card Services 3.1.22
Nov  8 09:06:46 radon-ntb kernel:   options:  [pci] [cardbus]
Nov  8 09:06:46 radon-ntb kernel: PCI: Found IRQ 11 for device 00:11.0
Nov  8 09:06:46 radon-ntb kernel: PCI: The same IRQ used for device
00:11.1
Nov  8 09:06:46 radon-ntb kernel: PCI: Found IRQ 11 for device 00:11.1
Nov  8 09:06:46 radon-ntb kernel: PCI: The same IRQ used for device
00:11.0
Nov  8 09:06:46 radon-ntb kernel: Yenta IRQ list 0698, PCI irq11
Nov  8 09:06:46 radon-ntb kernel: Socket status: 30000006
Nov  8 09:06:46 radon-ntb kernel: Yenta IRQ list 0698, PCI irq11
Nov  8 09:06:46 radon-ntb kernel: Socket status: 30000010
Nov  8 09:06:46 radon-ntb pcmcia:  cardmgr.
Nov  8 09:06:46 radon-ntb kernel: AVC: 9 messages suppressed.
Nov  8 09:06:46 radon-ntb kernel:
Nov  8 09:06:46 radon-ntb kernel: avc:  denied  { } for  pid=510
exe=/sbin/cardmgr path=/dev dev=00:05 ino=1
Nov  8 09:06:46 radon-ntb kernel:
scontext=system_u:system_r:cardmgr_t
Nov  8 09:06:46 radon-ntb kernel:
tcontext=system_u:object_r:unlabeled_t
Nov  8 09:06:46 radon-ntb kernel:    tclass=file
Nov  8 09:06:46 radon-ntb cardmgr[510]: starting, version is 3.1.22
Nov  8 09:06:46 radon-ntb rc: Starting pcmcia:  succeeded
Nov  8 09:06:47 radon-ntb random: Initializing random number generator:
succeeded
Nov  8 09:06:47 radon-ntb cardmgr[510]: no sockets found!
Nov  8 09:06:47 radon-ntb cardmgr[510]: exiting

My question is how i can modifiy the behavior of the AVC to make my
pcmcia cards work. Please can you give me an example.

Thanks in advance.

Hugo F. Martinez





*******************************************************************************************
Este mensaje y todos los archivos adjuntos a el son para uso exclusivo del destinatario y pueden contener informacion confidencial o propietaria, cuya divulgacion es sancionada por ley.

Si usted recibio este mensaje erroneamente, por favor notifiquenos respondiendo al remitente, borre el mensaje original y destruya las copias (impresas o grabadas en cualquier medio magnetico) que pueda haber realizado del mismo.

Todas las opiniones contenidas en este mail son propias del autor del mensaje y no necesariamente coinciden con las de CTI Movil o alguna de las empresas accionistas. La publicacion, uso, copia e impresion total o parcial de este mensaje o documentos adjuntos queda prohibida.

Muchas gracias
CTI Movil
*******************************************************************************************
This message and any attachments are for exclusive usage of an addressee and may contain confidential or privileged information whose disclosure is subject to penalty by law.

If you are not the addressee, please notify the sender by return e-mail, delete the original message and destroy any existing copy no matter if printed or recorded.

Any opinions contained in this e-mail are those of the author of the message and do not necessarily coincide with those of CTI Movil or its shareholders. No part of this message or attachments may be used or reproduced in any manner whatsoever.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
