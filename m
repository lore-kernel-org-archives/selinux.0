Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SCtqrT025821
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 08:55:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SCt3Hc007689
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 12:55:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: Latest Diffs.
Date: Sat, 28 Aug 2004 22:55:46 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <412CAE6B.30006@redhat.com> <1093614774.24188.23.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1093614774.24188.23.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SDIMBWQIn+CkM5k"
Message-Id: <200408282255.46693.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_SDIMBWQIn+CkM5k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 27 Aug 2004 23:52, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> Thanks.  Merged with some slight variations in named.te as follows.

Please include the following change.  AFAIK only Red Hat has /var/named.  
Debian uses /var/cache/named and /etc/bind/named.conf.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_SDIMBWQIn+CkM5k
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="named.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.diff"

--- /usr/src/se/policy/file_contexts/program/named.fc	2004-08-28 12:05:10.000000000 +1000
+++ file_contexts/program/named.fc	2004-08-28 22:53:56.000000000 +1000
@@ -1,8 +1,10 @@
 # named
+ifdef(`distro_redhat', `
 /var/named(/.*)?		system_u:object_r:named_zone_t
 /var/named/slaves(/.*)?		system_u:object_r:named_cache_t
 /var/named/data(/.*)?		system_u:object_r:named_cache_t
 /etc/named\.conf	--	system_u:object_r:named_conf_t
+') dnl end distro_redhat
 
 ifdef(`distro_debian', `
 /etc/bind(/.*)?			system_u:object_r:named_zone_t

--Boundary-00=_SDIMBWQIn+CkM5k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
