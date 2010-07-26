Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6RBLLL9004493
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 07:21:21 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6RBLGJm024388
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 11:21:16 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o6RBJmoU029124
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 07:19:48 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o6RBJmdb029122
	for selinux@tycho.nsa.gov; Tue, 27 Jul 2010 07:19:48 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6QKmR7A030560
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2010 16:48:27 -0400
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6QKmOUW028744
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2010 20:48:24 GMT
Received: by yxm8 with SMTP id 8so288528yxm.12
        for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2010 13:48:26 -0700 (PDT)
Message-ID: <4C4DF495.3000704@gmail.com>
Date: Mon, 26 Jul 2010 16:48:21 -0400
From: Ralph Blach <chipper19522@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: help with a compiled policy and port 443
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

good afternoon,
I happen to be a novice at selinux and wish more familiar with it.

This worked before but it does not work now.

I wish to put ssh on port 443

Before I used the commands


semanage port -d -t http_port_t -p tcp 443
semanage port -a -t sshd_port_t -p tcp 443

and these worked perfectly.

Now I get the error

semanage port -d -t http_port_t -p tcp 443
/usr/sbin/semanage: Port tcp/443 is defined in policy, cannot be deleted
[root@chipblach ~]#


How do I get around this and and get semanage to function?


what is a defined policy and how I edit it?

Thanks

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJMTfSMAAoJEI46azFTGseheOwP/R8ejDX/ft8ztJAUIPpkV+U1
rNU2LHtRm7h7yIEQpMBBERZs85A9QPPRJSTxilv+YF4a5O9hsEkR2F46Vpo1FWkr
Rxire9jelm0GRbXzm1nU6pQE8vMM0edbJl50iPWN4ju+1fa3gEGYcMLHCMlQYIab
kZWahqk7UuXmuytsjAo8AMq8FOa1ulZZREuB0QLQfOwERHdlwzShMC+kTCOf/O9r
bv62eJyVEdyuqHHKKeZoEnkFQJE8KwisitpOT0/7p90HWDWUkkrr53lGPDNH4ewT
a5c8Wfj5ASOkmkol7M/5zUIH25L1VIuovW0UQd2/37MesfTH+h0Q+7DCoAH3qVYQ
y3tjcB2Umh8aFsBipcsvOy5L6sVocmL4W8bQcXmsLvOV4rbxu5Tg6G941HSEVFoG
tSAdP05tnBSbLGIioY3F+vBsWNU9lIR7yf61FbEuIQSHMUyZdHlMmO8oROxz2zxl
jAl6SvlIY1Gjx5FJSTKG3gD9CW4FFlVtF7/tpmgtLqZz5qPUDtc8tbyJA8gMUSs8
cHlUFM+xGkeQPhwShTYtsgeZUC8zlseUzP4A9fNbVEppylbcb8wCFHvSdu+wj24D
4FJXtpSVit+63jvbA8bDlIzFWd4lXNMb1izsYGW5131O4Hb2lMrSOfSd9ORIycyX
39ZHXFU0jvaSaUObcP2z
=bLwO
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
