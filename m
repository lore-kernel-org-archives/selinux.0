Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NECTrT009296
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 10:12:29 -0400 (EDT)
Received: from www.pu.kielce.pl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NECSUk017672
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 14:12:28 GMT
Received: from [81.26.8.20] (port=45584 helo=[81.26.8.20] ident=pipen)
	by www.pu.kielce.pl with asmtp (TLS-1.0:DHE_RSA_RIJNDAEL_128_CBC_SHA:16)
	(Exim 4.30)
	id 1CAUH8-0007hL-5e
	for selinux@tycho.nsa.gov; Thu, 23 Sep 2004 16:08:46 +0200
Message-ID: <4152DA65.7090808@pu.kielce.pl>
Date: Thu, 23 Sep 2004 16:15:01 +0200
From: "Artur M. Piwko" <pipen@pu.kielce.pl>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Role questions
References: <41517FA8.7050207@pu.kielce.pl>
In-Reply-To: <41517FA8.7050207@pu.kielce.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Artur M. Piwko wrote:
> 1. When I su - from myuser:staff_r:staff_t to root I'm still myuser,
>    instead of root:staff_r:staff_t. What I did wrong?

Still working on it.

Naturally users are defined in /etc/selinux/src/users.

user root roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', 
`system_r') };
user myuser roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', 
`system_r') };

> 2. How can one set up initial sysadm_r password? All i see is:
> 
> # newrole -r sysadm_r
> Authenticating myuser.
> newrole: incorrect password for myser
> 

I browsed newrole.c. The problem was PAM.
This is what /etc/pam.d/newrole looked like after policycoreutils
installation:

auth     required  /lib/security/$ISA/pam_stack.so service=system-auth
account  required  /lib/security/$ISA/pam_stack.so service=system-auth
password required  /lib/security/$ISA/pam_stack.so service=system-auth
session  required  /lib/security/$ISA/pam_stack.so service=system-auth
session  optional  /lib/security/$ISA/pam_xauth.so

None of the libs were present. Removing these lines helped.
Same apply to /etc/pam.d/run_init.

-- 
Artur M. Piwko : AMP29-RIPE : ISPC:+48413496205 : jab:pipen@jabberpl.org
Akademia Swietokrzyska  ::  Uczelniane Centrum Informatyczne  ::  Kielce
PGP id:B969478F finger:35E6 E3A3 8120 F000 1375 5A1C 23A8 1A71 B969 478F
"Death is just life's way of telling you you've been fired"  --  unknown

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
