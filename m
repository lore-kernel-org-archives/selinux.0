Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6HA4crT004057
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 06:04:38 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6HA4FIR017319
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 10:04:15 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 17 Jul 2004 10:04:28 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BllWx-0007SF-EB
	for selinux@tycho.nsa.gov; Sat, 17 Jul 2004 09:30:55 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BlmEA-0002PX-2e
	for selinux@tycho.nsa.gov; Sat, 17 Jul 2004 11:15:34 +0100
Date: Sat, 17 Jul 2004 11:15:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: file_contexts patch
Message-ID: <20040717101533.GB8887@lkcl.net>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040716201531.GB4940@obadja.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

thomas,

i note the addition of /var/run/usb here.

is that because SuSE has modified the hotplug package
to place state information in that directory?

please advise, because i have raised a bug-request with
the debian hotplug maintainers, and i believe that the
upstream maintainers favour the use of /etc/hotplug/run
rather than /var/run/something.

the reason stated is because /var could be on a different partition
that may not have been mounted (bearing in mind that
/etc/init.d/mountall.sh is called first to mount local
partitions, and hotplug is pretty much immediately next,
and pretty much everything else is tertiary).

personally i think that reason is not good enough, because
if say you have /var on a firmware-based usb memory stick
(requiring a hotplug-generated event to load the firmware),
or /var is nfs-mounted over a firmware-based usb network card,
then you're really asking for a lot of trouble.

so, _if_ SuSE have made that decision, it would be good to know
the reasoning and to have some way of arm-twisting the hotplug
maintainers to a more sensible decision [that is FHS compliant
aside from anything else].

l.

On Fri, Jul 16, 2004 at 10:15:31PM +0200, Thomas Bleher wrote:
> The attached patch adds some file_contexts and most importantly labels
> libs under /opt correctly.
> 
> Please apply.
> 
> Thomas
> 
> -- 
> http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
> GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

> diff -urN orig/file_contexts/program/hotplug.fc mod/file_contexts/program/hotplug.fc
> --- orig/file_contexts/program/hotplug.fc	2004-06-19 10:31:43.000000000 +0200
> +++ mod/file_contexts/program/hotplug.fc	2004-07-16 22:10:08.000000000 +0200
> @@ -5,4 +5,5 @@
>  /etc/hotplug/.*agent	--	system_u:object_r:sbin_t
>  /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
>  /etc/hotplug/hotplug.functions --	system_u:object_r:sbin_t
> +/var/run/usb(/.*)?		system_u:object_r:hotplug_var_run_t
>  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
