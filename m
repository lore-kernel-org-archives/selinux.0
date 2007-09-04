Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84ENoOF004265
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 10:23:50 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84ENkrF026447
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:23:46 GMT
Message-ID: <46DD6A6C.2040305@redhat.com>
Date: Tue, 04 Sep 2007 10:23:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Athey <jathey@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] libselinux: refactored SWIG bindings
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>
In-Reply-To: <1181744873.18728.10.camel@exodus.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Athey wrote:
> I've attached refactored SWIG bindings for libselinux.  As
> requested, I've moved the Python specific wrappers into their own file.
> Here are some of the highlights:
> 
> * Should leak a lot less memory, because the wrapper handles memory
> management for lists and strings automatically
> * security_get_boolean_names is now usable
> * Instead of whitelisting functions to be wrapped, it blacklists
> functions that should not be wrapped
> 
> It's still not an ideal wrapper, partly because many functions still
> return two values - a return code, and the actual returned data.  In
> every language except C, the desired semantics would be just returning
> the data and throwing an exception if the return code != 0.  I didn't
> add this feature because it would definitely break existing code.
> 
> ~James
> 
> 

https://bugzilla.redhat.com/show_bug.cgi?id=276121

Bug in refactored SWIG Bindings.


#!/usr/bin/python

import selinux
args = [ "/bin/bash", "--version" ]
selinux.rpm_execcon(0, args[0], args, [ ])

Produces:

Traceback (most recent call last):
  File "test.py", line 5, in <module>
    selinux.rpm_execcon(0, args[0], args, [ ])
TypeError: in method 'rpm_execcon', argument 3 of type 'char *const []'

Version-Release number of selected component (if applicable):
libselinux-2.0.31-3.fc8

James do  you have a nice quick fix for this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG3WpsrlYvE4MpobMRAr6CAJ92i9x0z8pCLfrlLk8IxveRTAY1RgCdGl81
So55zob/LavO32xM1vQCdnc=
=qMG5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
