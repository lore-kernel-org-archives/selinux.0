Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24027
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 14:56:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA02228
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 18:54:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA02224
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 18:54:52 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA10592
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 14:56:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA22025
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 11:48:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA22157
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 15:46:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA22153
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 15:46:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: SE-Linux packages
Date: Fri, 20 Sep 2002 17:47:53 +0200
References: <20020920022148.GA12250@snoopy.apana.org.au>
In-Reply-To: <20020920022148.GA12250@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209201747.53722.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Sep 2002 04:21, Brian May wrote:
> [1] fileutils is not available; I cannot apply the patch cleanly
> to the stable version, and the unstable version requires a version
> of texinfo to build not available in stable (I might end up
> disabling building the documentation, same as Russell did).

I have just updated my patch for unstable to the latest "coreutils" based 
replacement for fileutils and shellutils.  You may want to base your work on 
that and maintain one package instead of two.

My coreutils stuff is in http://www.coker.com.au/selinux/coreutils/

> [3] If installing packages after the SE-Linux version of dpkg has
> been installed, but a SE-Linux kernel is not yet booted,
> /etc/dpkg/postinst.d/selinux broke badly, and I had to disable it.

Yes, you could have just removed the "-e" in that script though...

Probably should make the script check for a running SE kernel and only try to 
do anything if it's running.

> Comments?

Good work.  I'll remove my woody repository in the near future in favour of 
your work.

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
