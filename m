Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA13723
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 06:24:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA11886
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 11:22:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA11880
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 11:22:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: TCB - separating /etc/shadow into different files
Date: Mon, 27 Jan 2003 12:24:44 +0100
To: selinux@tycho.nsa.gov
Cc: Alexander Reelsen <ref@tretmine.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301271224.44099.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Anyone interested in this?

It would not be difficult to have a $1_shadow_t defined in 
macros/user_macros.te.

I think I'll re-write the policy for /bin/passwd to give a separate 
$1_passwd_t domain for each domain that runs it in preparation for such 
schemes.

I think that one useful feature of TCB is that it will make it easy to have 
administrative users allowed to change passwords for specific groups of users 
(EG university lecturer wants the ability to change passwords for students in 
their course).


I replied to the message on debian-devel and said that I think it offers no 
benefit without a MAC scheme, and that due to the limited acceptance of SE 
Linux and similar systems it doesn't make sense to change the main libc6 
package.  A private repository could be used instead.

----------  Forwarded Message  ----------

Subject: tcb for debian?
Date: Mon, 27 Jan 2003 09:40
From: Alexander Reelsen <ref@tretmine.org>
To: debian-devel@lists.debian.org

Hi

I was just taking a look at tcb from the openwall project. A quick look at
packages.debian.org revealed that it seems not to be included in debian
yet.

Quick description (from the manpage)
With  the  traditional password shadowing scheme, password hashes and
password aging  information  of  all  users  is stored  in one file,
/etc/shadow.  Therefore, if a process requires access to information on a
single  user,  it  is forced  to  possess  privileges  which  are
sufficient to access data on all users.  This is a design flaw, which is
most  clearly  visible  in  the case of passwd(1) utility.  Let's assume
that unprivileged users are to be allowed  to change  their  own
passwords.   Whatever  permissions are assigned to /etc/shadow, passwd(1),
invoked  by  unprivi- leged  user U, must be able to modify the contents
of this file.  If malicious user U finds  a  way  to  control  the
passwd(1)  process  (with the help of a buffer overflow or another bug in
the passwd(1) code,  in  the  libraries  it uses,  or  in the kernel), the
user will be able to change passwords of all users and thus obtain full
control  over the system.

The  solution  is  straightforward - each user is assigned its own,
separate shadow-style file.  User U's shadow file is  owned by U, so
passwd(1) invoked by U does not require superuser privileges.

The directory where all  users'  shadow  files  reside  is /etc/tcb.


The principle sounds quite good, however there is one major drawback:

The tcb package contains core components of our tcb suite implementing the
alternative password shadowing scheme on Owl. It is being made available
separately from Owl primarily for use by other distributions. Note that
you need to have the password hashing framework introduced with
crypt_blowfish patched into glibc to compile this.


It is very unlikely that such a small package which is not used that much,
will get into debian if the glibc has to be patched, right?
The glibc patch of the crypt_blowfish package is not even 2kb "big". (3
lines added, however some files have to be copied additionally and the
patch is for glibc 2.1.3)


MfG/Regards, Alexander

--
Alexander Reelsen   http://tretmine.org
ref@tretmine.org


--
To UNSUBSCRIBE, email to debian-devel-request@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
