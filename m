Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8KNtaKY029267
	for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 19:55:36 -0400
Received: from QMTA10.emeryville.ca.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8KNv3uq028982
	for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 23:57:03 GMT
Subject: Re: Naive question on ftp selinux policy
From: Chris PeBenito <pebenito@gentoo.org>
To: Elia Pinto <andronicus.spiros@gmail.com>
Cc: selinux@tycho.nsa.gov, Refpolicy Mailing List <refpolicy@oss1.tresys.com>
In-Reply-To: <51af93b70909201524j3993091ajaeaf42924d67ea6b@mail.gmail.com>
References: <51af93b70909201524j3993091ajaeaf42924d67ea6b@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 20 Sep 2009 16:55:02 -0700
Message-Id: <1253490902.2954.7.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-21 at 00:24 +0200, Elia Pinto wrote:
> A trivial question. There is some reason why the SELinux ref policy
> provides only for ftp access to users' home or to a type accessible to
> other demons confined? Why it is not possible to define a ftp_data_t
> also ? The motivation is simple : whay i have to provide ftp access
> AND also permit other daemon to access ? IMHO, it is not the best as
> Least privilege.

This question is best for the refpolicy list.  But the current policy
allows reading of the generic public files and conditionally (via
allow_ftpd_anon_write) it can write them.  There is nothing preventing
someone from adding something like ftp_ro_data_t and ftp_rw_data_t (or
just ftp_data_t if separate ro and rw data is not needed) for files that
are exclusively shared via ftp.

If you'd like to submit a patch to add the rules, please send it to the
refpolicy list.  I don't have a problem with adding this support.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
