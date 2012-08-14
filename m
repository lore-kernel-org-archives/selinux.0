Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7EE1xBQ018710
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 10:01:59 -0400
Received: by qaas11 with SMTP id s11so1891319qaa.12
        for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 07:01:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
References: <1344454290.25533.12.camel@localhost>
	<50293B11.9010105@redhat.com>
	<1344880524.16306.15.camel@lenny>
	<201208142118.42167.russell@coker.com.au>
	<CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
Date: Tue, 14 Aug 2012 10:01:57 -0400
Message-ID: <CACLa4ptRM3FcqanoagF=xUsvFZ1Ct9kEZW2uyiB7ECGK+zL0fg@mail.gmail.com>
Subject: Re: A filename to label translation daemon
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au
Cc: Colin Walters <walters@verbum.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Initial really really rough testing using pcre:

Load and free DB 100 times using GLIBC:
 8.370 seconds used by the processor.

Load and free DB 100 times using pcre:
 1.800 seconds used by the processor.

This is just using PCRE to load and compile the DB. Not using an
mmap'd precompiled version.  That's next on the testing list.  But
switching to pcre is already a huge time win it seems....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
