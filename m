Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I5AhHa010201
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 01:10:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7I59LOD015474
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 05:09:21 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h7I59KKO015471
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 05:09:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Kerry Thompson" <kerry@crypt.gen.nz>,
   "SELinux Mail List" <selinux@tycho.nsa.gov>
Subject: Re: SELinux on Slackware 9 with PAM
Date: Mon, 18 Aug 2003 15:10:29 +1000
Cc: "Diyab" <diyab@diyab.net>
References: <3F3896BD.5000307@diyab.net> <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz>
In-Reply-To: <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308181510.29857.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Aug 2003 13:27, Kerry Thompson wrote:
> - you should mention that the Vixie crond in the SE release has been
> modified for SELinux and really needs to be installed if you want cron.
> Alternatively the user would need to modify Dillon's crond code to support
> the SELinux extensions.

http://archives.neohapsis.com/archives/linux/lsap/2001-q1/0142.html
Solar Designer says some nice things about Dillon Cron at the above URL (the 
Linux Security Auditing Project mailing list - which should be of interest to 
people on this list).

It would be good to have some SE Linux patches to Dillon Cron if someone's got 
the time for the coding.

Especially as Vixie cron seems as good as dead upstream.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
