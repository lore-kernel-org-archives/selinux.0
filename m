Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69E8MHa023798
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 10:08:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h69E7PnJ023775
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 14:07:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h69E7Phr023772
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 14:07:25 GMT
Subject: Re: libsecure fails to compile
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057725650.6866.0.camel@columbia>
References: 
	 <B3B3B1C9A024D511B52C00D0B7201BDB07703D@ca-ex-remote1.na.nai.com>
	 <1057686414.12912.84.camel@moss-huskers.epoch.ncsc.mil>
	 <1057725650.6866.0.camel@columbia>
Content-Type: text/plain
Message-Id: <1057759698.4246.9.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jul 2003 10:08:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm unable to get to anonymous CVS right now as well, but the
SourceForge staff claims that as of 19 June the connection cap was
increased for the pserver and they believed that only at peak times
would the pserver be unavailable (returning a recv() error or "end of
file from server".)  See the SourceForge Site Status for details. If
this continues to be a problem let me know, and we'll look into creating
a nightly tarball from the SourceForge CVS.  But I really don't want to
have to take on that work if the pserver is available.

On Wed, 2003-07-09 at 00:40, Colin Walters wrote:
> On Tue, 2003-07-08 at 13:46, Stephen Smalley wrote:
> 
> > Side note:  The current release on nsa.gov is a bit dated (April 2003),
> > should be updated soon.  Between releases, you can typically get a more
> > up-to-date snapshot from the sourceforge CVS tree.
> 
> Do you know if there's a mirror anywhere?  sf.net's anonymous cvs has
> been unavailable for some time.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
