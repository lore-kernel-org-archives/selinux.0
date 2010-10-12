Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9CBdjEN030227
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 07:39:46 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9CBdfCE004272
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 11:39:42 GMT
Received: by iwn39 with SMTP id 39so3288327iwn.12
        for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 04:39:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com>
References: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com>
Date: Tue, 12 Oct 2010 07:39:38 -0400
Message-ID: <AANLkTi=RFa1UkhfHuq_dUUYaNaPD1yWnDwRQ+wZ8p-C_@mail.gmail.com>
Subject: Re: ERROR 'syntax error' at token ':c' on line 42:
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like the previously discussed flex bug, e.g.:
http://marc.info/?l=selinux&m=126763385807985&w=2

On Sun, Oct 10, 2010 at 2:17 AM, Justin Mattock <justinmattock@gmail.com> wrote:
> This is also hitting when building a module for the policy(below)
> basically start the system(opensuse 11.4) then do:
>
> dmesg > dmesg
> audit2allow -i dmesg -M Zonemod
> compilation failed:
> Zonemod.te:42:ERROR 'syntax error' at token ':c' on line 42:
> allow auditd_t device_t:chr_file { read write open };
> #============= auditd_t ==============
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> /usr/bin/checkmodule:  loading policy configuration from Zonemod.te
>
> ended up copying audit.log, messages, dmesg to another machine to make
> the modules
> then installed them on the machine that's produces this error, just to
> get up and running
> in enforcement mode.
>
> let me know what I can do.
>
> --
> Justin P. Mattock
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
