Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA04542
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 19:09:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA15422
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 23:08:04 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id XAA15403 for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 23:07:47 GMT
Date: Fri, 18 Oct 2002 09:10:11 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: latest policy patch
Message-ID: <20021017231011.GD15699@snoopy.apana.org.au>
References: <200210170017.38299.russell@coker.com.au> <200210171050.09887.russell@coker.com.au> <20021017144801.E19993@lemuria.org> <200210171546.46189.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210171546.46189.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 17, 2002 at 03:46:46PM +0200, Russell Coker wrote:
> Of course you could just run the following command when it first asks you 
> about changing policy:
> diff -ru /usr/share/selinux/policy/default /usr/share/selinux/policy/current \ 
> | grep -v ^Only

One suggestion with selinux-policy-default:

Installing the new policy should be optional when installing the Debian
package. Perhaps with a config option /etc/selinux-policy.conf (maybe)
or an extra question (but I am not a fan of all of these questions...).

I have, in the past, broken my running SE-Linux config, because it has
installed /usr/share/selinux/policy/current into the running kernel, but
I am not yet ready to use it...

(eg. once this occured when I deleted the "user bam" option. I intended
to fix this, but with the new kernel policy loaded, it would no longer
let me log in as sysadm_r, saying my current context was invalid).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
