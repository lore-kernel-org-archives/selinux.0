Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4MHAM03020953
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 13:10:22 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4MHALdN026290
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 17:10:21 GMT
Received: by wr-out-0506.google.com with SMTP id 36so1098191wra
        for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 10:10:21 -0700 (PDT)
Message-ID: <4471F07A.1000409@gmail.com>
Date: Tue, 23 May 2006 02:10:18 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: is it a newbie'sh question?: where is the log for violated access
 ?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I thought when an access violation occurs, it's logged in
/var/log/audit.log or messages, but it doesn't look so.

For example, If I invoke "su apache -c "cat /etc/passwd" as root which
will cause access error because apache user isn't allowed to use cat,
but I cannot find any violation log in any of the log files above.

Actually it's prohibited by selinux: ie.
as a root "su apache -c 'cat /etc/passwd'" will say nothing, while
"su maverick -c 'cat /etc/passwd'" (maverick is a normal user) displays
contents of /etc/passwd.  I think it's a form of access violation but
this isn't logged anywhere.   Will anyone tell me why or where it's logged?

Thanks in advance.

- -Tetsuji
- --
Tetsuji 'Maverick' Rai
Main http://maverick6664.bravehost.com/
Profile:
http://setiweb.ssl.berkeley.edu/beta/view_profile.php?userid=123
pubkey http://mav.atspace.com/tmr_at_gmail.txt
PGP Key ID: 82335CD9
Key fingerprint = 41CA 94B4 2A89 3FF1 5B11  BC37 D597 E667 8233 5CD9

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcfB51ZfmZ4IzXNkRAvHFAKDHHpesYfMN3s09kE7fjVmrcDPwtQCeOIH/
lO4DvEl/aJi7jcjqMD4BhRs=
=KWSB
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
