Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06134
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:03:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA02081
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:01:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA02052 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:01:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new policy
Date: Tue, 1 Oct 2002 19:02:36 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210011251050.14489-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210011251050.14489-100000@raven>
MIME-Version: 1.0
Message-Id: <200210011902.36463.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 18:53, Stephen Smalley wrote:
> I also dropped capabilities from
> netscape.  Do we need an entry for the .Xauthority files in types.fc?

Yes we do.  I think that we need to radically change the way setfiles works 
for home directories.  But in the mean time just adding something like the 
following to xauth.fc should do:
/home/[^/]*/.Xauthority.*     system_u:object_r:user_home_xauth_t


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
