Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5BMQQEr017917
 for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2014 18:26:27 -0400
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D1AFB1406E72C
 for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2014 00:26:25 +0200 (CEST)
Received: by mail-qc0-f181.google.com with SMTP id x13so673770qcv.40
 for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2014 15:26:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53965DC4.1090802@tresys.com>
References: <20140528170411.GA13025@siphos.be>
	<53965DC4.1090802@tresys.com>
Date: Thu, 12 Jun 2014 00:26:24 +0200
Message-ID: <CAJfZ7==jjeVo-g82L9=VOv92QF6=akK+5e+-VVmsf+wdvWR-yQ@mail.gmail.com>
Subject: Re: SETools patch for libselinux-2.3
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Sven Vermeulen <sven.vermeulen@siphos.be>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2014-06-10 3:22 GMT+02:00 Christopher J. PeBenito <cpebenito@tresys.com>:
> On 5/28/2014 1:04 PM, Sven Vermeulen wrote:
>> Index: secmds/replcon.cc
>> ===================================================================
>> --- secmds/replcon.cc (revision 4973)
>> +++ secmds/replcon.cc (working copy)
>> @@ -60,7 +60,7 @@
>>       {NULL, 0, NULL, 0}
>>  };
>>
>> -extern int lsetfilecon_raw(const char *, security_context_t) __attribute__ ((weak));
>> +extern int lsetfilecon_raw(const char *, const char *) __attribute__ ((weak));
>
> Unfortunately, this breaks it in the same way if you compile with libselinux < 2.3 with this patch.  The preference would be a patch that allows it to compile with any recent libselinux, rather than requiring libselinux 2.3.

When compiling SETools on ArchLinux I got this error message from gcc
(version 4.9.0):

replcon.cc:73:25: error: invalid operands of types '<unresolved
overloaded function type>' and 'long int' to binary 'operator!='
    if (lsetfilecon_raw != NULL)

I've never used weak functions in C libraries so I don't know the
proper fix to support libselinux versions which don't provide
lsetfilecon_raw, but as in ArchLinux only the most recent stable
version of packages is supported, I simply removed all the code
related to the "weak function trick" to make it works [1]. According
to git log, lsetfilecon_raw existed in 2008 [2]. Is it possible to
replace replcon_lsetfilecon with lsetfilecon_raw in SETools or are
there still supported versions of libselinux without lsetfilecon_raw?

By the way, while speaking about patches, a few days ago I wrote an
amazing bugfix for libsemanage [3]. Where should I send this patch? As
selinux@tycho.nsa.gov has been silent about my latest patch [4] I'm
wondering whether it is the right ML to send patches to.

Nicolas

[1] https://github.com/archlinuxhardened/selinux/blob/master/setools/0001-fix-compile-error.patch
[2] https://github.com/fishilico/selinux/blob/13cd4c8960688af11ad23b4c946149015c80d549/libselinux/src/lsetfilecon.c
[3] https://github.com/fishilico/selinux/commit/b9688372828d8f2609afb68160b100bdffd9ead0
[4] http://marc.info/?l=selinux&m=140086882622086&w=2
