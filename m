Message-ID: <COL109-W2831D1F228C1C0039B1FB7AB060@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b0b99157-408f-4283-b7ba-93f6ff1fa2f5_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A question about selinux userspace tools
Date: Mon, 10 Aug 2009 07:00:42 +0000
In-Reply-To: <1249649657.5213.72.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
 	 <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W364E77A3A4C0B0811DD604AB0A0@phx.gbl>
 	 <1249560616.5213.25.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W33EAFD3ECB726B75FBEA16AB0B0@phx.gbl>
 <1249649657.5213.72.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_b0b99157-408f-4283-b7ba-93f6ff1fa2f5_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Smalley,

Below are the information of my laptop you may want to know.

Anything I may help you investigate this issue just let me know.

Best regards,

Harry

---

cao@cao-laptop:~$ uname -a
Linux cao-laptop 2.6.27-7-generic #1 SMP Fri Oct 24 06:42:44 UTC 2008 i686 GNU/Linux
cao@cao-laptop:~$ grep flags /proc/cpuinfo 
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm ida
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm ida
cao@cao-laptop:~$ cat /proc/meminfo 
MemTotal:      3620032 kB
MemFree:       2152164 kB
Buffers:        157004 kB
Cached:         924304 kB
SwapCached:          0 kB
Active:         598820 kB
Inactive:       718548 kB
HighTotal:     2740532 kB
HighFree:      1562548 kB
LowTotal:       879500 kB
LowFree:        589616 kB
SwapTotal:     4000176 kB
SwapFree:      4000176 kB
Dirty:             144 kB
Writeback:           0 kB
AnonPages:      236060 kB
Mapped:          82024 kB
Slab:            92920 kB
SReclaimable:    67280 kB
SUnreclaim:      25640 kB
PageTables:       2700 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
WritebackTmp:        0 kB
CommitLimit:   5810192 kB
Committed_AS:   601344 kB
VmallocTotal:   110584 kB
VmallocUsed:     47668 kB
VmallocChunk:    59892 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
HugePages_Surp:      0
Hugepagesize:     4096 kB
DirectMap4k:     81920 kB
DirectMap4M:    835584 kB
cao@cao-laptop:~$ 

> Subject: RE: A question about selinux userspace tools
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Date: Fri, 7 Aug 2009 08:54:17 -0400
> 
> On Fri, 2009-08-07 at 02:04 +0000, TaurusHarry wrote:
> > Hi Smalley,
> > 
> > My laptop is i686.
> > 
> > Is there anything I could do to facilitate reproducing the same issue
> > on your side?
> 
> grep flags /proc/cpuinfo
> cat /proc/meminfo
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
您可以借助 Windows Live 整理、编辑和共享您的照片。
http://www.microsoft.com/china/windows/windowslive/products/photo-gallery-edit.aspx
--_b0b99157-408f-4283-b7ba-93f6ff1fa2f5_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
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
</style>
</head>
<body class='hmmessage'>
Hi Smalley,<br><br>Below are the information of my laptop you may want to know.<br><br>Anything I may help you investigate this issue just let me know.<br><br>Best regards,<br><br>Harry<br><br>---<br><br>cao@cao-laptop:~$ uname -a<br>Linux cao-laptop 2.6.27-7-generic #1 SMP Fri Oct 24 06:42:44 UTC 2008 i686 GNU/Linux<br>cao@cao-laptop:~$ grep flags /proc/cpuinfo <br>flags&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm ida<br>flags&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm ida<br>cao@cao-laptop:~$ cat /proc/meminfo <br>MemTotal:&nbsp;&nbsp;&!
 nbsp;&nbsp;&nbsp; 3620032 kB<br>MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2152164 kB<br>Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 157004 kB<br>Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 924304 kB<br>SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 598820 kB<br>Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 718548 kB<br>HighTotal:&nbsp;&nbsp;&nbsp;&nbsp; 2740532 kB<br>HighFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1562548 kB<br>LowTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 879500 kB<br>LowFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 589616 kB<br>SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp; 4000176 kB<br>SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4000176 kB<br>Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 144 kB<br>Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 236060 kB<br>Mapped:&nbs!
 p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82024 kB<br>Slab:&n
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92920 kB<br>SReclaimable:&nbsp;&nbsp;&nbsp; 67280 kB<br>SUnreclaim:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25640 kB<br>PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2700 kB<br>NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>WritebackTmp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>CommitLimit:&nbsp;&nbsp; 5810192 kB<br>Committed_AS:&nbsp;&nbsp; 601344 kB<br>VmallocTotal:&nbsp;&nbsp; 110584 kB<br>VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp; 47668 kB<br>VmallocChunk:&nbsp;&nbsp;&nbsp; 59892 kB<br>HugePages_Total:&nbsp;&nbsp;&nbsp;&nbsp; 0<br>HugePages_Free:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>HugePages_Rsvd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>HugePages_Surp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>Hugepagesize:&nbsp;&nbsp;&nbsp;&nbsp; 4096 kB<br>DirectMap4k:&nbsp;&nbsp;&nbsp;&nbsp; 81920 kB<br>DirectMap4M:&nbsp;&nbsp;&n!
 bsp; 835584 kB<br>cao@cao-laptop:~$ <br><br>&gt; Subject: RE: A question about selinux userspace tools<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Date: Fri, 7 Aug 2009 08:54:17 -0400<br>&gt; <br>&gt; On Fri, 2009-08-07 at 02:04 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi Smalley,<br>&gt; &gt; <br>&gt; &gt; My laptop is i686.<br>&gt; &gt; <br>&gt; &gt; Is there anything I could do to facilitate reproducing the same issue<br>&gt; &gt; on your side?<br>&gt; <br>&gt; grep flags /proc/cpuinfo<br>&gt; cat /proc/meminfo<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br><br /><hr />您可以借助 Windows Live 整理、编辑和 <a !
 href='http://www.microsoft.com/china/windows/windowslive/products/phot
o-gallery-edit.aspx' target='_new'>共享您的照片。</a></body>
</html>
--_b0b99157-408f-4283-b7ba-93f6ff1fa2f5_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
