Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u07MH1uf016238
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 17:17:01 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so145551800wmf.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jan 2016 14:16:37 -0800 (PST)
Received: from [192.168.0.10] (89-156-121-7.rev.numericable.fr. [89.156.121.7])
 by smtp.googlemail.com with ESMTPSA id i63sm15551451wmf.24.2016.01.07.14.16.35
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 07 Jan 2016 14:16:35 -0800 (PST)
Subject: Re: ANN: SELinux Userspace Release 20160107-rc1
To: selinux@tycho.nsa.gov
References: <568E8AA5.5030501@tresys.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <568EE3C3.4060907@m4x.org>
Date: Thu, 7 Jan 2016 23:16:35 +0100
MIME-Version: 1.0
In-Reply-To: <568E8AA5.5030501@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2016 04:56 PM, Steve Lawrence wrote:
> A release candidate for SELinux Userspace is now available at:
> 
> https://github.com/SELinuxProject/selinux/wiki/Releases
> 
> This has been tagged as 20160107-rc1 in the git repository.
> 
> Please give at a test and let us know if there are any issues.
> 
> Thanks,
> - Steve

Hello,

As I am updating my packages to test this -rc1, I encountered three very
minor problems with secilc:

1. The README says "libsepol >= 2.4", which seems not to be true.  I get
this error when compiling secilc with libsepol 2.4:

  secilc.c:298:7: error: too few arguments to function
  ‘cil_filecons_to_string’
    rc = cil_filecons_to_string(db, &fc_buf, &fc_size);
         ^
  In file included from secilc.c:40:0:
  /usr/include/sepol/cil/cil.h:47:12: note: declared here
    extern int cil_filecons_to_string(cil_db_t *db, sepol_policydb_t
  *sepol_db, char **o
              ^
  <builtin>: recipe for target 'secilc.o' failed
  make: *** [secilc.o] Error 1

The build is fine with libsepol 2.5-rc1, so I guess the dependency only
needs to be updated in the README file.

2. "make" does not build the man page.  This is because it defaults to
the first defined target in the Makefile, which is secilc, not "all",
unlike the other SELinux projects.  I was a little bit surprised that
"make" did not behave like "make all" but I guess this is not a big
deal.  Feel free not to "fix" this.

3. While reading the Makefile, I found that "man" target was missing
from the .PHONY line [2] and I do not know the precise consequences of
an incomplete .PHONY target.  Anyway "make all && make install" works fine.

Thanks,
Nicolas

[1]
https://github.com/SELinuxProject/selinux/blob/secilc-2.5-rc1/secilc/README#L14
[2]
https://github.com/SELinuxProject/selinux/blob/secilc-2.5-rc1/secilc/Makefile#L49
