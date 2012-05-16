Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4G9Iax0012849
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 05:18:36 -0400
Received: by eekc41 with SMTP id c41so118522eek.12
        for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 02:18:37 -0700 (PDT)
Date: Wed, 16 May 2012 11:17:36 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Trying to support Python 3 but fails on libsemanage
Message-ID: <20120516091736.GA10721@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to get Python 3 support up and going with the SELinux userspace
utilities. I'm hitting a compatibility issue that I'm not able to work out
further.

This is the following "test case":
	semanage fcontext -a -t swapfile_t /swapfile
	semanage fcontext -d -t swapfile_t /swapfile

With Python 2.7, this works as it should be. With Python 3.2 however, I get
the following error while trying to delete the entry:

/usr/sbin/semanage: File context for /swapfile is not defined

The entry is correctly available in the file_contexts.local file. Also, if I
switch from Python 3.2 to 2.7 after adding the entry (but before removing),
removing the entry works as it should be.

I notice that semanage calls seobject.py which calls semanage.py. All these
files are exactly the same (no changes made to those), so I guess it is
something to do within the _semanage.so file.

Now, this is a library created through swig magic, which i'm totally unknown
to. It looks like all code is C-based, and then transformed into a
Python-compatible call, not?

Is there anyone already running the SELinux userspace tools with Python 3?
If so, how do you build libsemanage (as that provides the _semanage.so
file)?

Wkr,
	Sven Vermeulen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
