Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3F0wLjr030960
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 20:58:21 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3F0wKQo017893
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 00:58:21 GMT
Received: by wa-out-1112.google.com with SMTP id m33so1942915wag.18
        for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 17:58:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49DE2AA9.3010608@kutulu.org>
References: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
	 <49DE2AA9.3010608@kutulu.org>
Date: Wed, 15 Apr 2009 09:58:19 +0900
Message-ID: <a5e2b64d0904141758o249e9f0fhfff1b56f3bf3a0bd@mail.gmail.com>
Subject: Re: Problems related to the policy language
From: Tim <timasyk@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My 2 cents on problems related to the policy language.

[View from embedded system developer]

Than might help to push SELinux into embedded Linux devices.

Path based files labeling using genfscon is _very_ limited. That
creates a lot of problems when non-xattr filesystems are used with
genfscon even with a patch that allows file granularity for labeling
(instead of filesystem granularity). Nature of the problem is:
- non-xattr filesystems are mounted into different mounting points often;
- directory names are same after mounting points, so it is hard to
specify correct labeling;
- read-only filesystems (usually non-xattr) often share same inode for
files with the same contents.

It is preferable to have simple "absolute path-based labeling" using
genfscon (or new keyword, e.g. genapcon) regardless of filesystem.
E.g.:
genfscon /opt/app/myapp  u:r:t   --- "myapp" and everything "below"
/opt/app/myapp will have u:r:t label

Of cause, there are known security issues with such approach (links),
but we can handle it.

Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
