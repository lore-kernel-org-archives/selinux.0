Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9V8kmWt018165
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 03:46:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9V8kTC7012833
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 08:46:29 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id h9V8kSuw012830
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 08:46:29 GMT
Date: Fri, 31 Oct 2003 09:46:35 +0100
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user's access to files in their own home directory
Message-ID: <20031031094635.F1540@lemuria.org>
References: <200310310610.14859.russell@coker.com.au> <20031030234711.GA31194@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031030234711.GA31194@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Fri, Oct 31, 2003 at 10:47:12AM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 10:47:12AM +1100, Brian May wrote:
> This would seem to imply a useability/security tradeoff that is
> dependant on the security requirements of the computer.
> 
> However, what files/dirs are you thinking of?

Anyone remember my "quarantine download dir" proposal from earlier this
year?

The basic idea:

~/Downloads/		system_u:object_r:untrusted_dir_t
file_type_auto_trans(.*, untrusted_dir_t, untrusted_file_t)
domain_auto_trans(.*, untrusted_file_t, untrusted_t)

And untrusted_t has a very restricted set of permissions. Especially it
can write nowhere except in untrusted_dir_t and /tmp. That way I can
"try out" stuff I found on the net.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
