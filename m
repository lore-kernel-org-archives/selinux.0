Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01665
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:41:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA03461
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:39:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA03457
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:39:29 GMT
Date: Tue, 1 Oct 2002 07:40:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux packages
In-Reply-To: <20021001100711.A19556@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210010736410.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Tom wrote:

> Is it possible that the selinux-policy-default is broken? I've done
> everything I could to make sure I have a clean build (including rm -rf
> /etc/selinux) and I still get several hundred errors on install or
> make. Here are some:
>
> ERROR 'permission access is not defined for class chr_file' at token ';' on line 4043:
> allow sysadm_su_t null_device_t:chr_file { ioctl read getattr access lock poll write append };

I posted a patch on 9/24 (signull-obsolete) that removed obsolete
permissions from the access vector definitions.  See
http://marc.theaimsgroup.com/?l=selinux&m=103289918201533&w=2.  It looks
like you are trying to compile a policy that still has those obsolete
permissions against the new access_vectors definitions, which naturally
won't work so well.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
