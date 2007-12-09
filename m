Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB9FpdDO031108
	for <selinux@tycho.nsa.gov>; Sun, 9 Dec 2007 10:51:39 -0500
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB9FpbQi006881
	for <selinux@tycho.nsa.gov>; Sun, 9 Dec 2007 15:51:37 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1204072rvb
        for <selinux@tycho.nsa.gov>; Sun, 09 Dec 2007 07:51:34 -0800 (PST)
Message-ID: <475C0E77.3010303@gmail.com>
Date: Sun, 09 Dec 2007 09:49:11 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Jeronimo Zucco <jczucco@ucs.br>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS Security Levels
References: <1197168914.475b59122bad7@webmail.ucs.br>
In-Reply-To: <1197168914.475b59122bad7@webmail.ucs.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can find this by looking in the spec file of the selinux-policy 
source rpm for MLS_CATS.

Jeronimo Zucco wrote:
>    How many is the atual max number of sensitivity level and max capabilities in
> a MLS security context ?
>
> In Fedora 5 was: s0-s15 and c0-c255. Today is the same values? Where can i get
> this information?
>
> --
> Jeronimo Zucco
> LPIC-1 Linux Professional Institute Certified
> Núcleo de Processamento de Dados
> Universidade de Caxias do Sul
>
> http://jczucco.blogspot.com
>
> ---------------------------------------
> Essa mensagem foi enviada pelo UCS Mail
>
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
