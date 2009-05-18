Subject: Re: threads and context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40905180621w2371ba26ya77b258c7a37bb9@mail.gmail.com>
References: <cadfc0e40905180621w2371ba26ya77b258c7a37bb9@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 09:52:32 -0400
Message-Id: <1242654752.20082.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-05-18 at 08:21 -0500, Xavier Toth wrote:
> What is the current situation regarding threads and their context? I
> remember seeing patches related to this subject posted awhile back
> were they upstreamed?

In Linux 2.6.28 and later, a thread in a multi-threaded process can
switch its context via setcon(3) iff the new SID is bounded by the old
SID (where bounded is defined via typebounds statements supported by
checkpolicy >= 2.0.17 and libsepol >= 2.0.34 and indicates that the
child context is never allowed more permissions than the parent
context).

There is a test policy and test case added for the type bounds support
in the ltp selinux testsuite, enabled in the cvs head.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
