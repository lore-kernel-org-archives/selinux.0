Message-ID: <002a01c0fe75$746d9020$9c34e9c0@sahad1>
From: "Pranav Saha" <psaha@bbn.com>
To: <SELinux@tycho.nsa.gov>
Subject: New to Linux - Need help
Date: Tue, 26 Jun 2001 15:23:18 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0027_01C0FE53.ED310F90"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C0FE53.ED310F90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello -=20

Our company is preparing to begin a project involving SELinux and I have =
been tasked to build a functioning SELinux box.  However, I am new to =
Linux (and obviously, SELinux) and am having some trouble with the =
installation.  I am installing on a RedHat 6.1 implementation, and get =
the error below while trying to do a 'make' on the modified kernel.  Am =
I missing a required library?  Any suggestions or help that can point me =
in the right direction would be much appreciated.

Apologies for the novice question.

Thanks,
Pranav Saha


------------------------------
arch/i386/kernel/kernel.o: In function `enable_irq':
arch/i386/kernel/kernel.o(.text+0x375b): undefined reference to =
`irq_vector'
arch/i386/kernel/kernel.o: In function `timer_interrupt':
arch/i386/kernel/kernel.o(.text+0x79cb): undefined reference to =
`smp_found_config'
arch/i386/kernel/kernel.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/kernel.o(.text+0xe98e): undefined reference to =
`pic_mode'
arch/i386/kernel/kernel.o: In function `init_VISWS_APIC_irqs':
arch/i386/kernel/kernel.o(.text+0xf057): undefined reference to =
`setup_x86_irq'
arch/i386/kernel/kernel.o: In function `pcibios_fixup_irqs':
arch/i386/kernel/kernel.o(.text.init+0x2ec0): undefined reference to =
`visws_get_PCI_irq_vector'
arch/i386/kernel/kernel.o: In function `do_boot_cpu':
arch/i386/kernel/kernel.o(.text.init+0x4684): undefined reference to =
`apic_version'
arch/i386/kernel/kernel.o: In function `smp_boot_cpus':
arch/i386/kernel/kernel.o(.text.init+0x4ba3): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4bdc): undefined reference to =
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x4bf2): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4bf9): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4c24): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4c2a): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4c31): undefined reference to =
`apic_version'
arch/i386/kernel/kernel.o(.text.init+0x4c59): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4c90): undefined reference to =
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x4ca4): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4cdf): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4d01): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4d1a): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4d2b): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4d5f): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o: In function `connect_bsp_APIC':
arch/i386/kernel/kernel.o(.text.init+0x4e86): undefined reference to =
`pic_mode'
arch/i386/kernel/kernel.o: In function `setup_local_APIC':
arch/i386/kernel/kernel.o(.text.init+0x4fc7): undefined reference to =
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x5053): undefined reference to =
`pic_mode'
arch/i386/kernel/kernel.o: In function `init_apic_mappings':
arch/i386/kernel/kernel.o(.text.init+0x5123): undefined reference to =
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x512c): undefined reference to =
`mp_lapic_addr'
arch/i386/kernel/kernel.o(.text.init+0x5175): undefined reference to =
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x5188): undefined reference to =
`boot_cpu_id'
security/ss.o: In function `sys_security_load_policy':
security/ss.o(.text+0x106e): undefined reference to `ss_initialized'
security/ss.o: In function `sys_security_get_user_sids':
security/ss.o(.text+0x1751): undefined reference to =
`security_get_user_sids'
drivers/pci/driver.o: In function `pci_fixup_device':
drivers/pci/driver.o(.text+0x119b): undefined reference to =
`pcibios_fixups'
make: *** [vmlinux] Error 1
---------------------------

------=_NextPart_000_0027_01C0FE53.ED310F90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3315.2870" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello - </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Our company is preparing to begin a =
project=20
involving SELinux and I have been tasked to build a functioning SELinux=20
box.&nbsp; However, I am new to Linux (and obviously, SELinux) and am =
having=20
some trouble with the installation.&nbsp; I am installing on a RedHat =
6.1=20
implementation, and get the&nbsp;error below while trying to do a 'make' =
on the=20
modified kernel.&nbsp; Am I missing a required library?&nbsp; Any =
suggestions or=20
help that can point me in the right direction would be much=20
appreciated.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Apologies for the novice =
question.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Pranav Saha</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>------------------------------</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>arch/i386/kernel/kernel.o: In function=20
`enable_irq':<BR>arch/i386/kernel/kernel.o(.text+0x375b): undefined =
reference to=20
`irq_vector'<BR>arch/i386/kernel/kernel.o: In function=20
`timer_interrupt':<BR>arch/i386/kernel/kernel.o(.text+0x79cb): undefined =

reference to `smp_found_config'<BR>arch/i386/kernel/kernel.o: In =
function=20
`disconnect_bsp_APIC':<BR>arch/i386/kernel/kernel.o(.text+0xe98e): =
undefined=20
reference to `pic_mode'<BR>arch/i386/kernel/kernel.o: In function=20
`init_VISWS_APIC_irqs':<BR>arch/i386/kernel/kernel.o(.text+0xf057): =
undefined=20
reference to `setup_x86_irq'<BR>arch/i386/kernel/kernel.o: In function=20
`pcibios_fixup_irqs':<BR>arch/i386/kernel/kernel.o(.text.init+0x2ec0): =
undefined=20
reference to `visws_get_PCI_irq_vector'<BR>arch/i386/kernel/kernel.o: In =

function `do_boot_cpu':<BR>arch/i386/kernel/kernel.o(.text.init+0x4684): =

undefined reference to `apic_version'<BR>arch/i386/kernel/kernel.o: In =
function=20
`smp_boot_cpus':<BR>arch/i386/kernel/kernel.o(.text.init+0x4ba3): =
undefined=20
reference to =
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x4bdc):=20
undefined reference to=20
`smp_found_config'<BR>arch/i386/kernel/kernel.o(.text.init+0x4bf2): =
undefined=20
reference to =
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x4bf9):=20
undefined reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4c24):=20
undefined reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4c2a):=20
undefined reference to=20
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x4c31): undefined =

reference to =
`apic_version'<BR>arch/i386/kernel/kernel.o(.text.init+0x4c59):=20
undefined reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4c90):=20
undefined reference to=20
`smp_found_config'<BR>arch/i386/kernel/kernel.o(.text.init+0x4ca4): =
undefined=20
reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4cdf):=20
undefined reference to=20
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x4d01): undefined =

reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4d1a):=20
undefined reference to=20
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x4d2b): undefined =

reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x4d5f):=20
undefined reference to =
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o: In=20
function =
`connect_bsp_APIC':<BR>arch/i386/kernel/kernel.o(.text.init+0x4e86):=20
undefined reference to `pic_mode'<BR>arch/i386/kernel/kernel.o: In =
function=20
`setup_local_APIC':<BR>arch/i386/kernel/kernel.o(.text.init+0x4fc7): =
undefined=20
reference to=20
`phys_cpu_present_map'<BR>arch/i386/kernel/kernel.o(.text.init+0x5053):=20
undefined reference to `pic_mode'<BR>arch/i386/kernel/kernel.o: In =
function=20
`init_apic_mappings':<BR>arch/i386/kernel/kernel.o(.text.init+0x5123): =
undefined=20
reference to =
`smp_found_config'<BR>arch/i386/kernel/kernel.o(.text.init+0x512c):=20
undefined reference to=20
`mp_lapic_addr'<BR>arch/i386/kernel/kernel.o(.text.init+0x5175): =
undefined=20
reference to =
`boot_cpu_id'<BR>arch/i386/kernel/kernel.o(.text.init+0x5188):=20
undefined reference to `boot_cpu_id'<BR>security/ss.o: In function=20
`sys_security_load_policy':<BR>security/ss.o(.text+0x106e): undefined =
reference=20
to `ss_initialized'<BR>security/ss.o: In function=20
`sys_security_get_user_sids':<BR>security/ss.o(.text+0x1751): undefined=20
reference to `security_get_user_sids'<BR>drivers/pci/driver.o: In =
function=20
`pci_fixup_device':<BR>drivers/pci/driver.o(.text+0x119b): undefined =
reference=20
to `pcibios_fixups'<BR>make: *** [vmlinux] Error 1</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>---------------------------</FONT></DIV></BODY></HTML>

------=_NextPart_000_0027_01C0FE53.ED310F90--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
