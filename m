Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07487
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 12:06:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA03865
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 17:06:50 GMT
Received: from [170.51.186.96] (cti015035.prima.com.ar [200.42.15.35])
	by jazzswing.ncsc.mil  with ESMTP id RAA03861
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 17:06:49 GMT
Received: from mail.cti.com.ar (unverified) by
 (Content Technologies SMTPRS 4.2.1) with SMTP id <T5718b38e7faa33ba6063c@> for <selinux@tycho.nsa.gov>;
 Thu, 8 Nov 2001 14:09:35 -0300
Received: from cti.com.ar (radon.cti [10.92.20.69])
	by ctinet.com.ar (8.8.6 (PHNE_17190)/8.8.6) with ESMTP id OAA08448
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 14:06:48 -0300 (SAT)
Message-ID: <3BEB0245.15AF2177@cti.com.ar>
Date: Thu, 08 Nov 2001 14:08:05 -0800
From: "Hugo F. Martinez" <hmartinez@cti.com.ar>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How can i configure this?
References: <Pine.GSO.4.33.0111081148500.17720-100000@raven>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I've got RedHat 7.1 and i did a full installation of SELinux
following
the Readme, and some tips from the Linux Magazine of september. Im using
devfs

Stephen Smalley wrote:

> On Thu, 8 Nov 2001, Hugo F. Martinez wrote:
>
> >     I've just have installed  selinux on my notebook to test it and
> > implement it on several servers if all my test works, and for acomplish
> > my tests in need your help if you can. On my new flask-kernel I've got
> > several messages from the AVC reporting that an action is denied. For
> > example i got the following when starting my pcmcia services:
>
> What is your base platform (e.g. RedHat 7.1)?  Did you do a full
> installation of SELinux?
>
> > Nov  8 09:06:46 radon-ntb kernel: avc:  denied  { } for  pid=510
> > exe=/sbin/cardmgr path=/dev dev=00:05 ino=1
> > Nov  8 09:06:46 radon-ntb kernel:
> > scontext=system_u:system_r:cardmgr_t
> > Nov  8 09:06:46 radon-ntb kernel:
> > tcontext=system_u:object_r:unlabeled_t
> > Nov  8 09:06:46 radon-ntb kernel:    tclass=file
>
> Is /dev just a normal directory in an ext2 filesystem, or are you
> using devfs?
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com


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
