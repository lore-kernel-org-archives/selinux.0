Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA00700
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 04:07:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA05256
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 08:05:34 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id IAA05252 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 08:05:33 GMT
Date: Tue, 1 Oct 2002 10:07:11 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux packages
Message-ID: <20021001100711.A19556@lemuria.org>
References: <20020920022148.GA12250@snoopy.apana.org.au> <20020927092947.GJ15981@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020927092947.GJ15981@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Fri, Sep 27, 2002 at 07:29:47PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 27, 2002 at 07:29:47PM +1000, Brian May wrote:
> I am currently copying newer versions of kernel-patch, kernel-source,
> kernel-image, and selinux, to the same location:
> 
> deb http://www.microcomaustralia.com.au/debian/ woody main selinux

Is it possible that the selinux-policy-default is broken? I've done
everything I could to make sure I have a clean build (including rm -rf
/etc/selinux) and I still get several hundred errors on install or
make. Here are some:

ERROR 'permission access is not defined for class chr_file' at token ';' on line 4043:
allow sysadm_su_t null_device_t:chr_file { ioctl read getattr access lock poll write append };
#line 4020
ERROR 'permission poll is not defined for class chr_file' at token ';' on line 4043:
allow sysadm_su_t null_device_t:chr_file { ioctl read getattr access lock poll write append };
#line 4020
ERROR 'permission poll is not defined for class udp_socket' at token ';' on line 4073:
allow sysadm_su_t self:udp_socket { create ioctl read getattr poll write setattr append bind connect getopt setopt shutdown };
#line 4020
ERROR 'permission poll is not defined for class tcp_socket' at token ';' on line 4075:
allow sysadm_su_t self:tcp_socket { create ioctl read getattr poll write setattr append bind connect getopt setopt shutdown listen accept };
#line 4020
ERROR 'permission poll is not defined for class udp_socket' at token ';' on line 4181:
allow sysadm_su_t mount_t:udp_socket { ioctl read getattr poll write setattr append bind connect getopt setopt shutdown };
#line 4020
ERROR 'unknown type shell_exec_t' at token ';' on line 4233:
allow sysadm_su_t shell_exec_t:file { getattr access execute };
#line 4020
/usr/sbin/checkpolicy:  error(s) encountered while parsing configuration


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
