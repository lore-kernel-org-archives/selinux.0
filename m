Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A6fRWt001143
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 02:41:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9A6fN0p028278
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:41:23 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9A6fJr7028275
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:41:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Subject: Re: newrules.pl -o option
Date: Fri, 10 Oct 2003 16:41:00 +1000
Cc: selinux@tycho.nsa.gov
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp> <1065723279.53567.0.camel@vorpal.mcs.drexel.edu> <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310101641.00039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 10:08, Yuichi Nakamura wrote:
> I added new option "-l" to newrules.pl.
> By "-l" option,logs only after last apperence of
> "load_policy"(avc:.*granted.*{.*load_policy.*}) are inputted. The new
> option is very convenient for me.

This new option is a great feature and will save a lot of people a lot of 
time.

However there is one minor problem, you use a fixed name for a temporary file 
under /tmp, which is a bad idea for several reasons.

Please make a new version which does not use a temporary file (sorting through 
it in an array should be easy enough) and I will gladly merge it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
