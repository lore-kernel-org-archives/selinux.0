Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA24500
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 18:52:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA26326
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 22:50:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA26322
	for <selinux@tycho.nsa.gov>; Mon, 16 Sep 2002 22:50:38 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: Fwd: Re: Any assured channel work for Linux
Date: Tue, 17 Sep 2002 00:51:51 +0200
To: tim@bird.org
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209170051.51285.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Sep 2002 00:45, Tim Bird wrote:
> Yes, this is basically what I was asking about.
>
> I seem to recall reading in one of the SELinux
> papers that they weren't tackling confidentiality
> yet (just really MAC (via DTE, et al)).  But I believe
> that what you have described meets the needs I
> was enquiring about.
>
> Is confidentiality (ie encrypted data transfer)
> over a channel like a pipe left as an excersize
> to the application, or are such IPCs deemed to
> be non-snoopable by other processes on the same
> machine, using just the LSM/SELinux mechanisms?

If everything is working correctly and if the administrator is trustworthy
then the SE Linux mechanisms should be adequate for the basic IPC mechanisms.

If things are not working correctly or if the administrator is untrustworthy
then you are stuffed.

Encryption over a pipe makes no sense to me.  Anyone who can intercept the
pipe can work aroun decryption by using ptrace on the applications, or other
methods.

For secure networking you need encryption of course.  SE Linux apparently has
some support for labelled networking over IPSec, but I haven't got IPSec
working yet so I don't know what it does exactly.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
