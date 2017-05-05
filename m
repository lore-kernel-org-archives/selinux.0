Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45ACfJP026689
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 06:12:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3C9561D38
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 10:12:37 +0000 (UTC)
Received: from hulk.com (ovpn-204-215.brq.redhat.com [10.40.204.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C99C81B4C
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 10:12:37 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol: Add INCLUDEDIR to utils/Makefile
Date: Fri,  5 May 2017 12:12:32 +0200
Message-Id: <20170505101233.13767-1-plautrba@redhat.com>
In-Reply-To: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
References: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dne 4.5.2017 v 22:49 Stephen Smalley napsal(a):
> On Thu, 2017-05-04 at 16:22 +0200, Petr Lautrbach wrote:
>> The patch is wrong, please disregard.
>>
>> I'm not sure about the right fix in order not to break gentoo use
>> case.
>> I'd just revert fcb5d5c change in libsepol/utils/Makefile for now.
>
> Can't you just specify CFLAGS to make, similar to what is done in the
> top-level Makefile for building with DESTDIR set?
>

I believe that ../include and ../src paths should be always added to CFLAGS
and LDFLAGS in this case to prevent cases when LDFLAGS and CFLAGS are overriden
on a command line without setting paths containing sepol.h and sepol.so.

This way it's already used in libsepol/src/Makefile

Petr
