Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03882
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 13:00:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA12789
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:59:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA12779
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:59:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "david caplan" <dac@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy and login names
Date: Tue, 24 Sep 2002 19:00:20 +0200
References: <GBEAJBKHFOBIBBJBCGAGKEKGCFAA.dac@tresys.com>
In-Reply-To: <GBEAJBKHFOBIBBJBCGAGKEKGCFAA.dac@tresys.com>
MIME-Version: 1.0
Message-Id: <200209241900.20427.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Sep 2002 16:32, david caplan wrote:
> We just ran across the case where we were trying to add a login name with a
> '.' in it.  When we tried to add the user to the policy, checkpolicy choked
> on the '.' in the id.  The parser expects an Identifier, which is defined
> to be a letter followed by a combination of letter|digit|_ of any length.

What about "chown user.group file"?  I think that alone is a good enough 
reason not to want to have a '.' in a user-name.

Of course there does not have to be any mapping between user-names and SE 
identities, and the SE identities should not be limited in the same way as 
Unix account names for this reason.

I could imagine a model where you might have Unixname.something as the SE 
identity...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
