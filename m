Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IK7NKI017549
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 16:07:23 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IK7Ml2023825
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 20:07:22 GMT
Received: by wr-out-0506.google.com with SMTP id 58so481817wri
        for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 13:07:22 -0700 (PDT)
Message-ID: <446CD37D.1020500@gmail.com>
Date: Fri, 19 May 2006 05:05:17 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: Is SELinux appropriate for my use?
References: <446A0CE9.6020708@gmail.com> <200605171558.43653.russell@coker.com.au>
In-Reply-To: <200605171558.43653.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> On Wednesday 17 May 2006 03:33, Tetsuji Maverick Rai 
> <tetsuji.maverick.rai@gmail.com> wrote:
>> I am dubious SELinux is necessary if I use only apache2 with phpBB and
>> other php based web applications.   Am I correct?   I am the only shell
>> user of the machine.
> 
> If an attacker cracks phpBB (which has been done before as you note) then 
> without SE Linux there is no restriction on their ability to try and crack 
> SETUID programs on the system.  When running SE Linux Apache is not permitted 
> to run /bin/passwd and other privileged programs so that someone who cracks 
> phpBB can not go on to attack such programs.
> 

Thank you for your reply.  But I still wonder....

What if apache's permission is set so that it isn't allowed to execute
most commands?    But actually most commands (i.e. even cat, ls) can be
dangerous, because it will display files containing mysql password.   So
does SELinux exist to prevent attackers from executing these "usual"
programs with http server's permissions(role)?   If so, I can understand
a bit....actually I understand this is secure.

And what's more?

I am writing this because SElinux isn't available with my favorite
reiserfs.   I need to use xfs or jfs to use SELinux (I don't like
ext2/3).  If reiserfs is compatible with SELinux, I'm sure I use
SELinux....or I am wondering I should move to jfs...(xfs is too slow.)

Regards,

- -tetsuji
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

iD8DBQFEbNN81ZfmZ4IzXNkRAj9zAJ9Vu+bq8nhFAo2i4GX3ycM2YLQZCQCfVfpj
Xvw97AKcjydhjeJfd3awKA8=
=vThj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
