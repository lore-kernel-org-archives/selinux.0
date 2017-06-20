Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KAsv0f030689
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 06:54:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E917BC04D292
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:54:53 +0000 (UTC)
Received: from [10.43.12.187] (unknown [10.43.12.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AABE600C1
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:54:53 +0000 (UTC)
Subject: Re: ANN: SELinux userspace 2.7-rc2 release
To: selinux@tycho.nsa.gov
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
 <20170618074655.GA9590@meriadoc.perfinion.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <6388c501-4700-ac73-fc1f-4b5a641cefba@redhat.com>
Date: Tue, 20 Jun 2017 12:54:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170618074655.GA9590@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2017 09:46 AM, Jason Zaman wrote:
> On Sun, Jun 18, 2017 at 03:32:33PM +0800, Jason Zaman wrote:
>> There is a bug that needs to be fixed before the final release:
>> https://bugs.gentoo.org/show_bug.cgi?id=621762
>>
>> I think the fix is just add override in utils/Makefile to the LDLIBS and
>> LDFLAGS bits. I'm not sure I'll have time to get around to testing
>> it so just wanted to let you know before the final release.
> 
> Yep, thats the fix, I sent a patch.
> https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libselinux/libselinux-9999.ebuild#n58
> The gentoo ebuild overrides LDFLAGS on the commandline which is why the
> override was required. When i first tried to repro manually i just
> exported LDFLAGS and couldnt repro. once i read the docs on override it
> was pretty obvious.

A similar patch is needed almost for every other part when you try to 
build everything from git first and then install it.

In order to that I need to apply a patch [1] and do the following steps:

ln -s ../../cil/include/cil libsepol/include/sepol/cil

make \
   CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
   LIBSEPOLA="`pwd`/libsepol/src/libsepol.a"

make -C libselinux \
   CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
   LIBSEPOLA="`pwd`/libsepol/src/libsepol.a" \
   PYTHON=%{__python} pywrap

make \
   DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}" \
   CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
   SHLIBDIR="%{buildroot}/%{_lib}" \
   BINDIR="%{buildroot}%{_bindir}" \
   SBINDIR="%{buildroot}%{_sbindir}" \
   PYTHON=%{__python} \
   install install-pywrap


[1] 
https://gitlab.com/bachradsusi/selinux-rpm/blob/master/0001-Fix-build-without-install.patch

Using this I preserve rpath problems pointing to DESTDIR and rpm can 
simply use everything from DESTDIR for /



Petr

>> -- Jason
>>
>> On Fri, Jun 16, 2017 at 12:55:09PM -0400, Stephen Smalley wrote:
>>> A second release candidate for the SELinux userspace is now available
>>> at:
>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>
>>> Please give it a test and let us know if there are any issues.
>>>
>>> Changes from the -rc1 release:
>>>
>>> James Carter (2):
>>>        libsepol: Fix neverallow bug when checking conditional policy
>>>        libsepol/cil: Fix bugs when writing policy.conf rules
>>>
>>> Nicolas Iooss (1):
>>>        libsepol: destroy the expanded level when
>>> mls_semantic_level_expand() fails
>>>
>>> Richard Haines (2):
>>>        libsepol/cil: ibendportcon fails to resolve in CIL policy
>>>        secilc: Update test policy and documentation for Infiniband
>>>
>>> Stephen Smalley (1):
>>>        Update VERSION files for 2.7-rc2 release.
>>>
>>> Vit Mojzis (1):
>>>        policycoreutils/fixfiles: do not dereference link files in tmp
