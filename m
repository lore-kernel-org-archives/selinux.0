Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Trivial question bout EXTRAVERSION and install destination
Date: Mon, 8 Jul 2002 19:15:25 -0500
MIME-Version: 1.0
Message-Id: <200207081915.25388.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

- From http://www.nsa.gov/selinux/doc/readme.html:

13) Configure your boot manager to boot the SELinux kernel.  

 You can determine the name of the new kernel by
looking in /boot.  The new kernel's name will end in "-selinux"
(example: "vmlinuz-2.4.18-selinux").  

SuSE kernels always install into /boot, but all othe end up in /, with generic names, including selinux's:

ccs001:/usr/src/selinux/policy # ls -l /
<snip>
- -rw-r--r--    1 root     root       520735 Jul  8 19:27 System.map
- -rw-r--r--    1 root     root       520735 Jul  8 17:20 System.old
- -rw-r--r--    1 root     root      1091691 Jul  8 19:27 vmlinuz
- -rw-r--r--    1 root     root      1091636 Jul  8 17:20 vmlinuz.old

1. What is wrong that's causing EXTRAVERSION to be ignored
2 Why are System.map and vmlinuz edning up in / instead of /boot ?

It's not a huge problem, but it's rather perplexing, especially since I had the exact same issue with a grsecurity-patched kernel

Thanks.

- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KisdQ5u80xXOLBcRAlDgAJ9pFU48hKd0cpDT1Ce5fPdd2St1MgCePiZm
Nbjn0fAlizOG9WtMO2C5cGY=
=i1l+
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
