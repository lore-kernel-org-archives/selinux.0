Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA27497
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 18:23:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA04459
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 23:22:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA04455
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 23:22:23 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: NSA SE enabled devfsd
Date: Wed, 6 Mar 2002 00:23:02 +0100
Cc: devfs@oss.sgi.com, Debian Devel <debian-devel@lists.debian.org>
MIME-Version: 1.0
Message-Id: <20020305232303.15D571BBC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have hacked support for SE Linux into devfsd.

For example the following line in a devfsd config will set the SID of 
/dev/null:
REGISTER ^null                  SELINUX system_u:object_r:null_device_t

If the devfsd sees that you are not running an SE kernel, or if you compile 
the devfsd without SE Linux support then the SELINUX "what" actions will be 
silently ignored for compatability.

The file selinux-config on my site has all the sample /dev policy converted 
to the format my hacked devfsd uses.

The file devfsd-se.diff is the diff between the non-SE and the SE versions of 
devfsd, it was created against the Debian patched devfsd package, but should 
apply to a clean devfsd tree.

There is also full source to devfsd, Debian package source, and a Debian 
package.

The URL is http://www.coker.com.au/selinux/devfsd/

To the NSA people: please do not put any of this code on your site or take 
any formal notice of it yet.  Richard should be given a chance to review it 
before we go any further (he may require small but problematic changes such 
as a different "what" keyword).

At the moment this is just a proof of concept.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
