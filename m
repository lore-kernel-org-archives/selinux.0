Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA477hXZ021260
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 02:07:43 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA476LCH005048
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 07:06:22 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA46vS0n029154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 00:57:36 -0600
To: selinux@tycho.nsa.gov
Subject: Re: Updated SELinux Release
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	<87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
	<1099539462.5018.2.camel@nexus.verbum.private>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Thu, 04 Nov 2004 00:57:23 -0600
In-Reply-To: <1099539462.5018.2.camel@nexus.verbum.private> (Colin Walters's
	message of "Wed, 03 Nov 2004 22:37:42 -0500")
Message-ID: <87oeieqey4.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 03 Nov 2004 22:37:42 -0500, Colin Walters <walters@verbum.org> said: 

>> Unfortunately, this has not been accompanied with an soname change,
>> this can't be a good thing.  I would suggest bumping up the soname
>> to match the version (libsepol.so.1.2), to minimize confusion.

> I don't think anyone has actually been using these functions up
> until now.  Neither Debian or Fedora enabled MLS, and I don't think
> Gentoo did either.  So it's probably safe to continue using the
> existing soname; but we should certainly be careful about this in
> the future.

	All right. Since Debian has not yet shipped a version of
 libsepol (it is still in incoming), I have noproblem with not bumping
 the soname.

	manoj
-- 
A good marriage would be between a blind wife and deaf husband. Michel
de Montaigne
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
