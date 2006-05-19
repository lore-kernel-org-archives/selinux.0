Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JHYvUn011967
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 13:34:58 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JHYtfP009936
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 17:34:56 GMT
Received: by wr-out-0506.google.com with SMTP id 58so655930wri
        for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:34:55 -0700 (PDT)
Message-ID: <446E01BB.4090600@gmail.com>
Date: Sat, 20 May 2006 02:34:51 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: Is SELinux appropriate for my use?
References: <446A0CE9.6020708@gmail.com> <200605171558.43653.russell@coker.com.au>            <446CD37D.1020500@gmail.com> <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
In-Reply-To: <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 19 May 2006 05:05:17 +0900, Tetsuji Maverick Rai said:
> 
>> What if apache's permission is set so that it isn't allowed to execute
>> most commands?    But actually most commands (i.e. even cat, ls) can be
>> dangerous, because it will display files containing mysql password.   So
>> does SELinux exist to prevent attackers from executing these "usual"
>> programs with http server's permissions(role)?   If so, I can understand
>> a bit....actually I understand this is secure.
> 
> Remember - the design of SELinux is that *nothing* is permitted, unless
> there's something in the policy that specifically says it's allowed.
> So Apache can't even run /bin/cat unless there is a rule that says something
> in httpd_t context (apache) is allowed to run bin_t binaries (bin_t includes
> most common binaries).  However, /bin/ls *isn't* a bin_t, there's a separate
> ls_exec_t for it, so things like ftpd can be restricted to be able to
> run /bin/ls, but not other things in /bin.
> 

Thank you for clarifying that.  I understand it's very secure in
invoking other commands from PHP.  Then how about this situation?   PHP
itself has several functions manipulate files and mysql databases (of
course there are much more, but I use mainly mysql).  I guess *if* PHP
is hacked, arbitrary mysql functions (and others) are executed freely,
and my mydql database can be damaged.  Is it right?

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

iD8DBQFEbgG61ZfmZ4IzXNkRArJtAJ0QmZpWAAIVEquf6yHJh8YYLYdZ4QCdHWMn
nhej+ZdMkjKDXsj+mxiiIlk=
=niUJ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
