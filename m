Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9D9oJWt013274
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 05:50:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9D9oIUb020355
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 09:50:18 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9D9oHhX020352 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 09:50:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erlend Aasland <erlend-a@ux.his.no>,
   SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Users are not assigned correct security context on login
Date: Mon, 13 Oct 2003 19:50:09 +1000
References: <20031013110626.GA10270@badne3.ux.his.no>
In-Reply-To: <20031013110626.GA10270@badne3.ux.his.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310131950.09485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Oct 2003 21:06, Erlend Aasland wrote:
> However, after doing a "make reload", rebooting and logging in as root,
> "id" shows this:
> uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:user_t

It looks like you have not installed the SE Linux patched /bin/login or the SE 
Linux PAM module (for new SE Linux).  If you do one of those things then it 
should all work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
