Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n48HnQG5027421
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 13:49:26 -0400
Received: from wa-out-1112.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n48HnOUr028027
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 17:49:25 GMT
Received: by wa-out-1112.google.com with SMTP id k40so606437wah.18
        for <selinux@tycho.nsa.gov>; Fri, 08 May 2009 10:49:24 -0700 (PDT)
Subject: how to enable gconf(arole_dbus_t errors) and all of the gnome
 goodies
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain
Date: Fri, 08 May 2009 10:49:28 -0700
Message-Id: <1241804968.1819.9.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

with the latest policy:
I'm wondering what would be the best way to
allow gconf,evolution,nautilus,etc..

If I start any of these during boot I'll
get system_dbus_t(which gets allowed)
but if I start evolution, nautilus, etc..
normally once Ive booted up I get an error 
with checkpolicy.(due to arole_dbus_t instead of
system_dbus_t)

Should I try and compile these programs
without orbit support(if possible), gconf support
and dbus support?

is there a boolean that I'm missing?

Justin P. Mattock




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
