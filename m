Message-ID: <BAY111-W103B9EF7D73E86CFDF3688AB5E0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f0ae2824-6473-4689-80cc-b4b2603c9cd4_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <refpolicy@oss1.tresys.com>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 4:login
 successfully finally!
Date: Tue, 26 Jan 2010 08:50:46 +0000
In-Reply-To: <1264433745.4297.159.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,, ,
 ,,<4B53CEB9.3050207@gmail.com>,,<BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,,
 ,
 ,,<4B543977.40007@gmail.com>,,<BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>,,
 ,
 ,,<4B550EB9.50806@gmail.com>,,<BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>,,
 ,,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>,,,<BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>,,,<1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>,,<BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>,<BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>,<1264433745.4297.159.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_f0ae2824-6473-4689-80cc-b4b2603c9cd4_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

With all the kind help from you and Justin, I finally made the latest refpolicy-2.20091117 boot up successfully! Hat off for you two :-)

Please see my embedded replies, thanks!

> Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3: MAKEDEV ok but /var/lock/subsys/ broken
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
> Date: Mon, 25 Jan 2010 10:35:45 -0500
> 
> On Mon, 2010-01-25 at 09:32 +0000, TaurusHarry wrote:
> > Hi Stephen and Justin,
> > 
> > I have got some new findings after I sent out the previous email. The
> > weird error messages about /var/lock/subsys/ turns out to be hard disk
> > inconsistency problem and could be fixed by fsck.ext2, after that,
> > find and touch performed by rc.sysinit or /etc/rc3.d/* would have no
> > problem at all :-)
> > 
> > However, my console still hangs at "INIT: Id "0" respawning too fast:
> > disabled for 5 minutes", although so far I think I have fixed all
> > those obvious problems with SELinux during boot up and I could no
> > longer find fishy AVC denied message except something like:
> > 
> > type=1400 audit(1264435478.992:5): avc:  denied  { rawip_send } for
> > pid=5 comm="sirq-timer/0"
> > saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> > daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> > scontext=system_u:system_r:kernel_t:s15:c0.c255
> > tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif
> > type=1400 audit(1264435478.992:6): avc:  denied  {! rawip_send } for
> > pid=5 comm="sirq-timer/0"
> > saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> > daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> > scontext=system_u:system_r:kernel_t:s15:c0.c255
> > tcontext=system_u:object_r:node_t:s0-s15:c0.c255 tclass=node
> 
> Hmm..so you don't have secmark enabled by default?  Kernel config?

$ grep SECMARK linux-sun_cp3020-cgl-build/.config
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
$

More secmark options should I enable?

> 
> > But I don't think they could be the reason /sbin/init would fail to
> > run /sbin/mingetty.
> > 
> > Then I came up with the idea to toggle SELinux state into Permissive
> > mode in the rc.local and finally the console on longer hangs and I
> > could login normally:
> > 
> > 
> > 
> > root@cp3020:/root> cat /proc/cmdline 
> > 
> > root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1
> > BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 
> > 
> > root@cp3020:/root> getenforce 
> > 
> > Permissive
> > 
> > root@cp3020:/root>
> > 
> > root@cp3020:/root> cat /var/log/messages
> > 
> > ...
> > 
> > Jan 25 16:59:15 cp3020 /etc/rc3.d/S95atd: atd startup - OK
> > 
> > Jan 25 16:59:15 cp3020 boot: Starting cracklibd
> > 
> > Jan 25 16:59:16 cp3020 boot: Starting local
> > 
> > Jan 25 16:59:16 cp3020 kernel: type=1404 audit(1264438756.016:4):
> > enforcing=0 ol
> > 
> > d_enforcing=1 auid=4294967295 ses=4294967295
> > 
> > ...
> > 
> > root@cp3020:/root>
> > 
> > 
> > We can see selinux does boot up WITH enforcing=1 but toggled into
> > enforcing=0 at rc.local, which proves that all my left problem focused
> > on /sbin/mingetty
> > 0:2345:respawn:/sbin/mingetty console  (in my /etc/inittab)
> > 
> > Maybe I need to identify the changes from refpolicy-2.20081210 to
> > refpolicy-2.20091117 related with getty_t.
> 
> Rebuild policy with dontaudits removed (semodule -DB) and retry, then
> look for audit messages involving getty.

Yeah, I created a policy store and then do semodule -DB and reboot, I found AVC denied messages about domains of sendmail_t, hostname_t, quota_t, dmesg_t lack the read privilege against console_device_t, which is expected because we have called term_dontaudit_use_console() interface for these domains.

Since so far we have identified that my problem is rooted with getty_t, so I went on to take a quick glance at getty.te and very suprisingly found this dontaudit interface has been called for getty_t too! For me I am trying to login my target through a serial console, rather than any tty device, so I assume the getty_t should be granted all necessary privileges to operate the console. Once I removed the term_dontaudit_use_console(getty_t) I could find following AVC denied message:




	
	
	
	

type=1400
audit(1264520547.936:68): avc:  denied  { noatsecure } for  pid=2292
comm="login"
scontext=system_u:system_r:getty_t:s0-s15:c0.c255
tcontext=system_u:system_r:local_login_t:s0-s15:c0.c255
tclass=process


which I guess is right the root cause to my problem. Once I replaced it by term_use_console(getty_t), I finally could login successfully!

This problem made me sleepless for like 10 days and I would like to take this opportunity to summarize it here:
1. use enforcing=0 bootparam if unable to login selinux, then dmesg all those AVC denied messages for potential extra TE rules;
2. problem could be caused by files not being properly labeled, as well as necessary TE rules are missing. In my case many domains has no search right against tmpfs_t, however, tmpfs_t doesn't exist even in file_contexts, this indicates tmpfs  filesystem has not been properly labeled. It turns out start_udev should have labeled tmpfs once it mounts tmpfs on /dev;
3, if perblem persists but no relevant AVC denied messsage could be referenced, use semodule -DB to rebuild policy and remove all those dontaudit rules, or remove the call to some dontaudit interface in the related .te, so thar SELinux could throw out as many AVC denied messages as possible.

Next, I will go on play with the latest refpolicy package and bring up the extra necessary TE rules I find.

Thank you so very much, again!

Best regards,
Harry


> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
_________________________________________________________________
上Windows Live 中国首页，下载Messenger2009安全版！
http://www.windowslive.cn
--_f0ae2824-6473-4689-80cc-b4b2603c9cd4_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
Hi Stephen,<br><br>With all the kind help from you and Justin, I finally made the latest refpolicy-2.20091117 boot up successfully! Hat off for you two :-)<br><br>Please see my embedded replies, thanks!<br><br>&gt; Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3: MAKEDEV ok but /var/lock/subsys/ broken<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov<br>&gt; Date: Mon, 25 Jan 2010 10:35:45 -0500<br>&gt; <br>&gt; On Mon, 2010-01-25 at 09:32 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi Stephen and Justin,<br>&gt; &gt; <br>&gt; &gt; I have got some new findings after I sent out the previous email. The<br>&gt; &gt; weird error messages about /var/lock/subsys/ turns out to be hard disk<br>&gt; &gt; inconsistency problem and could be fixed by fsck.ext2, after that,<br>&gt; &gt; find and touch performed by rc.sysinit or /etc/rc3.d/* would have no<br>&gt; &gt; problem at all :-)<br!
 >&gt; &gt; <br>&gt; &gt; However, my console still hangs at "INIT: Id "0" respawning too fast:<br>&gt; &gt; disabled for 5 minutes", although so far I think I have fixed all<br>&gt; &gt; those obvious problems with SELinux during boot up and I could no<br>&gt; &gt; longer find fishy AVC denied message except something like:<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(1264435478.992:5): avc:  denied  { rawip_send } for<br>&gt; &gt; pid=5 comm="sirq-timer/0"<br>&gt; &gt; saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3<br>&gt; &gt; daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5<br>&gt; &gt; scontext=system_u:system_r:kernel_t:s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif<br>&gt; &gt; type=1400 audit(1264435478.992:6): avc:  denied  {! rawip_send } for<br>&gt; &gt; pid=5 comm="sirq-timer/0"<br>&gt; &gt; saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3<br>&gt; &gt; daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5<br>&gt; &gt;!
  scontext=system_u:system_r:kernel_t:s15:c0.c255<br>&gt; &gt; tcontext
=system_u:object_r:node_t:s0-s15:c0.c255 tclass=node<br>&gt; <br>&gt; Hmm..so you don't have secmark enabled by default?  Kernel config?<br><br>$ grep SECMARK linux-sun_cp3020-cgl-build/.config<br>CONFIG_NETWORK_SECMARK=y<br># CONFIG_NETFILTER_XT_TARGET_SECMARK is not set<br>$<br><br>More secmark options should I enable?<br><br>&gt; <br>&gt; &gt; But I don't think they could be the reason /sbin/init would fail to<br>&gt; &gt; run /sbin/mingetty.<br>&gt; &gt; <br>&gt; &gt; Then I came up with the idea to toggle SELinux state into Permissive<br>&gt; &gt; mode in the rc.local and finally the console on longer hangs and I<br>&gt; &gt; could login normally:<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; root@cp3020:/root&gt; cat /proc/cmdline <br>&gt; &gt; <br>&gt; &gt; root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1<br>&gt; &gt; BOOT_IMAGE=/vlm-boards/12885/qcao/kernel <br>&gt; &gt; <br>&gt; &gt; root@cp3020:/root&gt; getenforce <br>&gt; &gt; <br>&gt; &gt; Per!
 missive<br>&gt; &gt; <br>&gt; &gt; root@cp3020:/root&gt;<br>&gt; &gt; <br>&gt; &gt; root@cp3020:/root&gt; cat /var/log/messages<br>&gt; &gt; <br>&gt; &gt; ...<br>&gt; &gt; <br>&gt; &gt; Jan 25 16:59:15 cp3020 /etc/rc3.d/S95atd: atd startup - OK<br>&gt; &gt; <br>&gt; &gt; Jan 25 16:59:15 cp3020 boot: Starting cracklibd<br>&gt; &gt; <br>&gt; &gt; Jan 25 16:59:16 cp3020 boot: Starting local<br>&gt; &gt; <br>&gt; &gt; Jan 25 16:59:16 cp3020 kernel: type=1404 audit(1264438756.016:4):<br>&gt; &gt; enforcing=0 ol<br>&gt; &gt; <br>&gt; &gt; d_enforcing=1 auid=4294967295 ses=4294967295<br>&gt; &gt; <br>&gt; &gt; ...<br>&gt; &gt; <br>&gt; &gt; root@cp3020:/root&gt;<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; We can see selinux does boot up WITH enforcing=1 but toggled into<br>&gt; &gt; enforcing=0 at rc.local, which proves that all my left problem focused<br>&gt; &gt; on /sbin/mingetty<br>&gt; &gt; 0:2345:respawn:/sbin/mingetty console  (in my /etc/inittab)<br>&gt; &gt; <br>&gt; &gt; Ma!
 ybe I need to identify the changes from refpolicy-2.20081210 to<br>&gt
; &gt; refpolicy-2.20091117 related with getty_t.<br>&gt; <br>&gt; Rebuild policy with dontaudits removed (semodule -DB) and retry, then<br>&gt; look for audit messages involving getty.<br><br>Yeah, I created a policy store and then do semodule -DB and reboot, I found AVC denied messages about domains of sendmail_t, hostname_t, quota_t, dmesg_t lack the read privilege against console_device_t, which is expected because we have called term_dontaudit_use_console() interface for these domains.<br><br>Since so far we have identified that my problem is rooted with getty_t, so I went on to take a quick glance at getty.te and very suprisingly found this dontaudit interface has been called for getty_t too! For me I am trying to login my target through a serial console, rather than any tty device, so I assume the getty_t should be granted all necessary privileges to operate the console. Once I removed the term_dontaudit_use_console(getty_t) I could find following AVC denied message:<!
 br><br>


	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8">
	<title></title>
	<meta name="GENERATOR" content="OpenOffice.org 2.4  (Linux)">
	<style type="text/css">
	<!--
		@page { size: 21cm 29.7cm; margin: 2cm }
		P { margin-bottom: 0.21cm }
	-->
	</style>

<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">type=1400
audit(1264520547.936:68): avc:  denied  { noatsecure } for  pid=2292
comm="login"
scontext=system_u:system_r:getty_t:s0-s15:c0.c255
tcontext=system_u:system_r:local_login_t:s0-s15:c0.c255
tclass=process
</font></font></font></p>
<br>which I guess is right the root cause to my problem. Once I replaced it by term_use_console(getty_t), I finally could login successfully!<br><br>This problem made me sleepless for like 10 days and I would like to take this opportunity to summarize it here:<br>1. use enforcing=0 bootparam if unable to login selinux, then dmesg all those AVC denied messages for potential extra TE rules;<br>2. problem could be caused by files not being properly labeled, as well as necessary TE rules are missing. In my case many domains has no search right against tmpfs_t, however, tmpfs_t doesn't exist even in file_contexts, this indicates tmpfs&nbsp; filesystem has not been properly labeled. It turns out start_udev should have labeled tmpfs once it mounts tmpfs on /dev;<br>3, if perblem persists but no relevant AVC denied messsage could be referenced, use semodule -DB to rebuild policy and remove all those dontaudit rules, or remove the call to some dontaudit interface in the related .te, !
 so thar SELinux could throw out as many AVC denied messages as possible.<br><br>Next, I will go on play with the latest refpolicy package and bring up the extra necessary TE rules I find.<br><br>Thank you so very much, again!<br><br>Best regards,<br>Harry<br><br><br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  <br /><hr />搜索本应是彩色的,快来体验新一代搜索引擎-必应,精美图片每天换哦! <a href='http://cn.bing.com/?form=CRMADS ' target='_new'>立即试用！</a></body>
</html>
--_f0ae2824-6473-4689-80cc-b4b2603c9cd4_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
