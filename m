Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA14599
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 14:27:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA07239
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 19:26:29 GMT
Received: from [170.51.186.96] (cti015035.prima.com.ar [200.42.15.35])
	by jazzband.ncsc.mil  with ESMTP id TAA07229
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 19:26:24 GMT
Received: from mail.cti.com.ar (unverified) by
 (Content Technologies SMTPRS 4.2.1) with SMTP id <T571e5a0c41aa33ba6063c@> for <selinux@tycho.nsa.gov>;
 Fri, 9 Nov 2001 16:29:32 -0300
Received: from cti.com.ar (radon.cti [10.92.20.69])
	by ctinet.com.ar (8.8.6 (PHNE_17190)/8.8.6) with ESMTP id QAA18839
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 16:26:47 -0300 (SAT)
Message-ID: <3BEC7497.58C585C5@cti.com.ar>
Date: Fri, 09 Nov 2001 16:28:07 -0800
From: "Hugo F. Martinez" <hmartinez@cti.com.ar>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problems with pcmcia
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi i just installed selinux-200110161355 on RedHat 7.1 compiled ok but
when i want to compile a module for my pcmcia card (WaveLAN) i get the
following error message.

[root@radon-ntb wireless]# make all
cc   -MD -O3 -Wall -Wstrict-prototypes -pipe -I../include/static
-I/usr/src/slinux/kernel/include -I../include  -D__KERNEL__ -DMODULE -c
netwave_cs.c
In file included from /usr/src/slinux/kernel/include/asm/uaccess.h:8,
                 from ../include/static/asm/uaccess.h:49,
                 from ../include/pcmcia/k_compat.h:161,
                 from netwave_cs.c:41:
/usr/src/slinux/kernel/include/linux/sched.h: In function
`process_file_mac_permission':
/usr/src/slinux/kernel/include/linux/sched.h:957: structure has no
member named `i_sid'
make: *** [netwave_cs.o] Error 1

Thanks in advance



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
