Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13666
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 08:58:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA16604
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:56:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA16600 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:56:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec access to { sysadm_tty_device_t sysadm_devpts_t }
Date: Wed, 28 Aug 2002 14:57:57 +0200
References: <200208281228.HAA06721@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200208281228.HAA06721@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <20020828125757.B48098F6E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 14:28, Jesse Pollard wrote:
> Russell Coker <russell@coker.com.au>:
> > Now I'm working on ipsec which seems to require { read write ioctl
> > getattr } access to those device types for correct functioning.  As I am
>
> Slightly OT/side question:
>
> Which IPSec implementation are you starting with - NIST reference,
> Free/swan or a completely new one?

I'm using Free/swan, I wasn't aware that I had a choice.  Could you please 
give us a brief analysis of the difference between the different versions?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
