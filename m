Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2HMYuvO032597
	for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2007 18:34:56 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2HMYs4c022236
	for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2007 22:34:54 GMT
Received: by nf-out-0910.google.com with SMTP id n15so641720nfc
        for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2007 15:34:45 -0700 (PDT)
Message-ID: <e739902b0703171534x795e8802jeec1427f63043df7@mail.gmail.com>
Date: Sat, 17 Mar 2007 15:34:44 -0700
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Incorrect comment or toolchain problem in refpolicy policy/modules/kernel/kernel.te?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I found the following comment in the kernel.te refpolicy module:

# These initial sids are no longer used, and can be removed:

So naturally, I attempted to remove the sids ... but I got the
following error when compiling the policy:

Compiling refpolicy policy.21
/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
libsepol.policydb_load_isids: SID (null) was never defined
make: *** [policy.21] Error 1

I do go through all the sids and commented each one out individually
to see if there was a subset that could be removed.   What I found is
that if any of the sids were removed, it caused a compile error.

Is the comment in the module incorrect?  Or is this a toolchain problem?

Thanks!

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
