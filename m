Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0KGFfIi005653
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 11:15:41 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0KGDdbQ027708
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 16:13:39 GMT
Subject: Re: Error building libsepol with gcc 4.0
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87hdlmuoeq.fsf@glaurung.internal.golden-gryphon.com>
References: <87hdlmuoeq.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106235589.26753.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 10:39:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 20:07, Manoj Srivastava wrote:
>         There is a problem building 'libsepol' on amd64 with gcc-4.0:
> 
> cc -O2 -I. -I../include -c -o policydb.o policydb.c
> policydb.c:29: error: static declaration of 'policydb_compat' follows non-static declaration
> private.h:27: error: previous declaration of 'policydb_compat' was here
> make[2]: *** [policydb.o] Error 1
> make[2]: Leaving directory `/libsepol-1.2/src'
> 
> 	Which is indeed a problem (though gcc used to ignore it in the
>  past). Looking at it, policydb_compat is only used in policydb.c, so
>  it can remain a static array of struct policydb_compat_info, and we
>  can just remove the extern declaration from private.h.

Thanks, merged into sourceforge CVS as of libsepol version 1.2.1.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
