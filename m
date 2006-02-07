Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k17Dc2Xf022718
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 08:38:03 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k17DahxN020929
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 13:36:43 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Goo GGooo'" <googgooo@gmail.com>, <Valdis.Kletnieks@vt.edu>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: SElinux from scratch
Date: Tue, 7 Feb 2006 08:37:58 -0500
Message-ID: <028201c62beb$b5373180$8c0d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <ef5305790602070111j11ace845h20a21c5b89a7b939@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Goo GGooo wrote:
> Actually my goal isn't the apache hardening itself. I just want to
> learn more about SElinux configuration. Starting from scratch with a
> single program (forget httpd, call it /opt/xyz/bin/abc), configuring
> access to its required resources, observing how any changes affect
> its operation, etc. I'm not going to use Fedora and simply "switch
> SElinux on".     
> 
> Have you got any pointers?

Certainly looking at examples in existing policies will help and is a good
starting point, though all the macros makes it difficult to see the raw
policy language if that is your goal. We have a 3-day course which we
haven't taught in a while, but the slides are available at
http://www.tresys.com/selinux/. They might help (a one-day version of this
which focuses the policy language semantics and syntax is at the SELinux
symposium.) That same web site has a detailed listing of all object classes
and permissions which you will eventually have to understand.

(And for shameless plug...) Karl MacMillan, Dave Caplan, and I also have a
book to be published in a couple months from Prentice Hall which among other
things is a detailed reference of the policy language (a couple chapter
teaser of which will be distributed at the upcoming symposium). Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
