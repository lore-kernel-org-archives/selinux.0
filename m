Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s69FDEkM028396
 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2014 11:13:14 -0400
Received: by mail-wi0-f178.google.com with SMTP id f8so2453276wiw.17
 for <selinux@tycho.nsa.gov>; Wed, 09 Jul 2014 08:13:16 -0700 (PDT)
Received: from siphos.be (ip-83-134-10-147.dsl.scarlet.be. [83.134.10.147])
 by mx.google.com with ESMTPSA id di7sm103955912wjb.34.2014.07.09.08.13.15
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jul 2014 08:13:15 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Wed, 9 Jul 2014 17:12:16 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: pcre compiled context files invalid with pcre updates?
Message-ID: <20140709151216.GA8142@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

In Gentoo, we notice some unexpected behavior with the compiled
file_contexts files after upgrading (lib)pcre:

https://bugs.gentoo.org/show_bug.cgi?id=516608

I think what is happening is that the pcre data, which is built with one
pcre version, is not (fully) compatible with a more recent pcre version. In
the changelog of pcre I find type changes of (internal or not) variables by
pcre.

If this assumption is correct, perhaps we should store the pcre version used
to build the *.bin files in the file itself. Right now we store a magic (to
make sure it is a compiled file_contexts file) and a version specific for
libselinux, but not a version specific for PCRE.

The pcre header defines PCRE_MAJOR and PCRE_MINOR which we can use.

Do you think the above analysis makes sense? The bug linked earlier on has a
gdb backtrace for those interested. Any other pointers that might help us
troubleshoot this would be appreciated.

Wkr,
	Sven Vermeulen
