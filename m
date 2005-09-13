Subject: Re: Problem compiling libselinux 1.26
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pierre <pierre42d@9online.fr>
Cc: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <4325DE1A.2000408@9online.fr>
References: <4325DE1A.2000408@9online.fr>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 08:58:26 -0400
Message-Id: <1126616306.29303.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 21:59 +0200, Pierre wrote:
> # make
> make -C src
> make[1]: Entering directory `/tmp/libselinux-1.26/src'
> gcc -s -O3 -march=i686 -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
> -c -o fgetfilecon.o fgetfilecon.c
> fgetfilecon.c:6:23: sys/xattr.h: No such file or directory
> make[1]: *** [fgetfilecon.o] Error 1
> make[1]: Leaving directory `/tmp/libselinux-1.26/src'
> make: *** [all] Error 2

If you have a modern glibc (>= 2.3) built against modern kernel headers
(>= 2.4.20, or any 2.6 kernel), then getxattr/setxattr and sys/xattr.h
should be provided by glibc.  Previously, they were provided by libattr,
with its header in attr/xattr.h, but since the xattr system calls were
mainstreamed, glibc has been supporting them directly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
