Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9885KWt017538
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 04:05:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9885J7d011415
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:05:19 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
        by jazzband.ncsc.mil  with ESMTP id h9885IRn011412 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:05:19 GMT
Date: Wed, 8 Oct 2003 10:00:10 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: 2.6.0-test6 boot process failures
Message-ID: <20031008100006.F11916@lemuria.org>
References: <20031007230348.E11325@lemuria.org> <200310081341.12645.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310081341.12645.russell@coker.com.au>; from russell@coker.com.au on Wed, Oct 08, 2003 at 01:41:12PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 08, 2003 at 01:41:12PM +1000, Russell Coker wrote:
> I'm not really surprised that my script didn't work - I had never tested it 
> and you don't expect untested code to work.
> 
> Where's Colin's script?

It's in his selinux-policy-default package. Here's the script:

#!/bin/sh -e
# Install binary policy file and load_policy utility for loading it.
test -n "$INITRDDIR"
mkdir -p "$INITRDDIR"/selinux
mkdir -p "$INITRDDIR"/etc/security/selinux
mkdir -p "$INITRDDIR"/scripts
cp -a /etc/security/selinux/policy.15 "$INITRDDIR/etc/security/selinux/policy.15"
cp -a /usr/sbin/load_policy "$INITRDDIR/bin/load_policy"
cp -a /usr/share/selinux/initrd-script "$INITRDDIR/scripts/selinux"


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
