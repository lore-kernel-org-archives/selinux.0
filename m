Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KD27Wt019491
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:02:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KD1o0p024199
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:01:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KD1or7024196
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:01:50 GMT
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <200310192301.20068.russell@coker.com.au>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org>
	 <200310190035.06420.russell@coker.com.au>
	 <20031019121044.GA29052@wavehammer.waldi.eu.org>
	 <200310192301.20068.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066654911.22196.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 09:01:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-10-19 at 09:01, Russell Coker wrote:
> On Sun, 19 Oct 2003 22:10, Bastian Blank wrote:
> > On Sun, Oct 19, 2003 at 12:35:06AM +1000, Russell Coker wrote:
> > > This has already been discussed and a patch has already been posted to
> > > the list.  I expect that the next release will have this fixed.
> >
> > do you have any pointer to the patch?
> 
> Here is the message with the patch:
> http://marc.theaimsgroup.com/?l=selinux&m=106557438826674&w=2

That patch wasn't merged, as it causes the static library to also be
installed to /lib.  Instead, a patch by Dan Walsh (available from his
SRPM, under ftp://people.redhat.com/dwalsh/SELinux/srpms) was merged to
only install libselinux.so to /lib, and his spec file was
correspondingly adjusted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
