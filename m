Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBEGM4Ii012485
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 11:22:04 -0500 (EST)
Received: from web50205.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id iBEGM6fN008615
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 16:22:06 GMT
Message-ID: <20041214162207.5089.qmail@web50205.mail.yahoo.com>
Date: Tue, 14 Dec 2004 08:22:07 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [patch] selinux_capget()
To: James Morris <jmorris@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@redhat.com> wrote:

> On Mon, 13 Dec 2004, Casey Schaufler wrote:
> 
> > Briefly, the intent of the POSIX specification
> > is that you should not "correct" the effective set
> > due to the impact of additional policies or
> > conditions.
> 
> How does the application determine the real
> effective set?

The short answer is that it doesn't. How do you
determine if you can really open a file for write
access? The real world behavior is to check what
you know about (e.g. UID, mode bits) and hope that
you'll pass any additinoal constraints (e.g. ACLS,
capabilities, mount options) that might apply. Then
try it and check the error return.

> (confusing enough terms ? :-)

If you think this is a confusing set of terms you
should have been in Denver when we found out that
the term "privilege" had an ISO definition, and so
we had to change the draft to use something else.
Leave it that capabilities with all it's terminology
issues was the best choice.

> Surely it is a reasonable thing to expect to be able
> to do.

Indeed it is. Unfortunatly, the best suggested
interface I've seen is on the lines of:

     canido("open(\"/somewhere/file\", O_WRITE)");

which is a generalized version of access(2), that
notoriously unuseful syscall. Needless to say, such
an inferface is impracticle and would still yield
false positives.

> I'm not sure
> that your example is valid here as euid==0 doesn't
> mean anything in
> SELinux (if it did, the application could check that
> first and infer that
> it has all capabilities).

Many applications do check to see if they're running
as root and (attempt to) behave differently if they
are. And, you will gain no ground whatever if you
try to get the developers of such applications to
mend their evil ways. Applications that use privilege
must be aware of the privilege mechanisms that
constrain them.

My example come from the capability implementation
in IRIX, where privilege is granted if you have
the effective capability or if you are root. In
Trusted Irix (Trix to it's friends) the uid is not
used in privilege checks, you must have the 
capability. The POSIX draft specification permits
either implementation. The application that cares
about the security environment it resides in and
does anything more sophisticated than trying
the operation and reacting to errors will have a
tough row to hoe.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
