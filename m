Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7U2f8EN020967
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 22:41:08 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7U2f7r0004749
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 02:41:07 GMT
Received: by py-out-1112.google.com with SMTP id u77so2883145pyb
        for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 19:41:02 -0700 (PDT)
Message-ID: <8f34198c0708291941n12f2de55y787893586b69fbb5@mail.gmail.com>
Date: Thu, 30 Aug 2007 10:41:01 +0800
From: "Ian jonhson" <jonhson.ian@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>, pam-list@redhat.com
Subject: how to run the pam_selinux_check to test SELINUX
Cc: "Daniel J Walsh" <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I enabled the SELINUX on my FedoraCore4, and test pam_selinux_check.c
(distributed with Linux-PAM-0.99). However, it seems that it doesn't
work, and I have no idea how to do next.

The configuration steps about SELINUX:

1. After I installed my FC4, I set the SELINUX=enforcing in
/etc/sysconfig/selinux;

2. reboot my system. It seems that SELINUX have take in effect, the
FC4 checked and labeled the filesystem...

Then, I configured the PAM in /etc/pam.d/. My steps are as following:

1. create a new PAM configuration file in /etc/pam.d/, named
pam_selinux_check, and edited it as follows:

session  sufficient  pam_selinux.so

2. compile the pam_selinux_check.c

OK. Now I tested the pam_selinux_check and want to see some work
details about SELINUX.

#  ./pam_selinux_check
#                                    /*  <--  nothing happen */

Again, test it with a parameter

# ./pam_selinux_check  tom
#                                   /*  <--  nothing happed too */

did it righ?

I don't know what I have missed in my configuring the selinux and pam.
Maybe, one of the missing is that I just set enforcing in
/etc/sysconfig/selinux, not together with setting SELINUXTYPE=strict.
However, when I set SELINUXTYPE=strict, I got a error message at
booting and system dump. The error message said, I have set nothing
about strict policy.
But I don't know how to install strict policy.

I just test the functionalities about selinux MAC enforcement, so
where can I download a simple strict policy, and how to install in my
FC4+SELINUX?

As for PAM, it seems the configuration file is right, since I found
the pam_selinux.so only built the PAM session hooks.

I don't know what wrong with it, could anybody give me some advices?


Thanks in advance,

Ian

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
