Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA05582
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 02:20:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA02054
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 06:18:47 GMT
Received: from unicorn.lemuria.org (b069161.adsl.hansenet.de [62.109.69.161])
        by jazzband.ncsc.mil  with ESMTP id GAA02050 for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 06:18:46 GMT
Date: Fri, 18 Oct 2002 08:20:01 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: latest policy patch
Message-ID: <20021018082000.D25703@lemuria.org>
References: <200210170017.38299.russell@coker.com.au> <200210171050.09887.russell@coker.com.au> <20021017144801.E19993@lemuria.org> <200210171546.46189.russell@coker.com.au> <20021017231011.GD15699@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021017231011.GD15699@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Fri, Oct 18, 2002 at 09:10:11AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 18, 2002 at 09:10:11AM +1000, Brian May wrote:
> One suggestion with selinux-policy-default:
> 
> Installing the new policy should be optional when installing the Debian
> package. Perhaps with a config option /etc/selinux-policy.conf (maybe)
> or an extra question (but I am not a fan of all of these questions...).

Yes, please. It could simply check if a policy is already installed,
and if so, ask "should I update your policy?" just like every other
debian package does before changing config files. It could then
automatically step over all the files that I choose not to have the
first time, to reduce the number of questions asked.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
