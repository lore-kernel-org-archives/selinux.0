MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA8FDD.4EBE7307"
Subject: RE: Help with an SELinux AVC event...
Date: Thu, 7 Jan 2010 16:05:57 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D02DF4965@de01exm68.ds.mot.com>
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>	 <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>	 <D06FE0A2807BC145B0D38744789D4F5D02DF4964@de01exm68.ds.mot.com> <1262897031.2821.88.camel@moss-pluto.epoch.ncsc.mil> <4B464986.9070601@redhat.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA8FDD.4EBE7307
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Awesome ! What would I do without this maillist.  Thanks soo much for =
your wonderful help as always  :-)


-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com]
Sent: Thu 1/7/2010 3:52 PM
To: Stephen Smalley
Cc: Hasan Rezaul-CHR010; Tomas, Gregg A (IS); selinux@tycho.nsa.gov
Subject: Re: Help with an SELinux AVC event...
=20
On 01/07/2010 03:43 PM, Stephen Smalley wrote:
> On Thu, 2010-01-07 at 15:37 -0500, Hasan Rezaul-CHR010 wrote:
>> Hi All,
>>
>> I have a C application task called "sswd" on my Linux system, that
>> opens up the /var/log/audit/audit.log file every 5 seconds, and =
checks
>> to see if there are any new AVC denies.
>>
>> I have had this same task doing the same thing for the last few years
>> on a Linux system running selinux. And I have never seen these events
>> in audit.log before complaining about the sswd task... I used to use
>> older selinux packages, and ran the Fedora Core 7 'strict' policy
>> together with some custom policies.
>>
>> Recently we upgraded our SELinux packages to the very latest (similar
>> to Fedora 12), and we are using Refpolicy as a base policy.
>>
>> In the /var/log/audit/audit.log file, I see the following event pop =
up
>> every 5 seconds, and I am guessing its because "sswd" tries to open =
up
>> the audit.log file every 5 seconds for reading.
>>
>> 1. Can you help me understand what this event is really saying?
>> 2. I have already taken the audit.log file, and used audit2allow to
>> generate any allow rules necessary, but it didnt help to get rid of
>> this particular event.
>> 3. Can I add any specific policy allow lines or transition rules in =
my
>> custom policy files to get rid of this repeated event ?
>>
>> Thanks in advance.
>>
>> The event that pops up every 5 seconds in audit.log is:
>>
>> type=3DSYSCALL msg=3Daudit(1262874266.422:260): arch=3D14 syscall=3D5
>> success=3Dyes exit=3D24 a0=3D1002b9e4 a1=3D0 a2=3D1b6 a3=3D1b6 =
items=3D1 ppid=3D2463
>> pid=3D2794 auid=3D4294967295 uid=3D0 gid=3D601 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D601
>> sgid=3D601 fsgid=3D601 tty=3D(none) ses=3D4294967295 comm=3D"sswd"
>> exe=3D"/usr/app/bin/sswd" =
subj=3Dsystem_u:system_r:init_t:s0-s15:c0.c255
>> key=3D"LOG_audit"
>> type=3DCWD msg=3Daudit(1262874266.422:260):  cwd=3D"/data"
>> type=3DPATH msg=3Daudit(1262874266.422:260): item=3D0
>> name=3D"/var/log/audit/audit.log" inode=3D2061 dev=3Dfd:07 =
mode=3D0100600
>> ouid=3D0 ogid=3D0 rdev=3D00:00
>> obj=3Dsystem_u:object_r:auditd_log_t:s15:c0.c255
>=20
> That's your audit configuration (/etc/audit/audit.rules), not SELinux.
> You have an audit rule that says to log all access to the audit log
> file, presumably copied from the sample audit rules for the CAPP or =
LSPP
> configurations.  Looks like this in audit.rules:
> -w /var/log/audit/ -k LOG_audit
>=20
> I think you'd be better off using audispd to dispatch audit events to
> your program rather than directly reading audit.log yourself.
>>
>> root@hapWibbSc2:/var/log/audit# ps -eZ | grep sswd
>> system_u:system_r:init_t:s0-s15:c0.c255 2781 ? 00:00:00 sswd
>>
>> root@hapWibbSc2:/var/log/audit# cd /usr/app/bin
>> root@hapWibbSc2:/usr/app/bin# ls -l sswd
>> -rwxrwxr-x 1 root root 217204 Jan  1 07:49 sswd
>>
>> root@hapWibbSc2:/usr/app/bin# cd /var/log/audit/
>> root@hapWibbSc2:/var/log/audit#
>> root@hapWibbSc2:/var/log/audit# ls -lZ
>> -rw-------  root root system_u:object_r:auditd_log_t:s15:c0.c255
>> audit.log
>>
>>
>>
You probably want to steal the code in sedisp in the setroubleshoot =
package, since this is exactly what it does.


------_=_NextPart_001_01CA8FDD.4EBE7307
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: Help with an SELinux AVC event...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Awesome ! What would I do without this maillist.&nbsp; =
Thanks soo much for your wonderful help as always&nbsp; :-)<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Daniel J Walsh [<A =
HREF=3D"mailto:dwalsh@redhat.com">mailto:dwalsh@redhat.com</A>]<BR>
Sent: Thu 1/7/2010 3:52 PM<BR>
To: Stephen Smalley<BR>
Cc: Hasan Rezaul-CHR010; Tomas, Gregg A (IS); selinux@tycho.nsa.gov<BR>
Subject: Re: Help with an SELinux AVC event...<BR>
<BR>
On 01/07/2010 03:43 PM, Stephen Smalley wrote:<BR>
&gt; On Thu, 2010-01-07 at 15:37 -0500, Hasan Rezaul-CHR010 wrote:<BR>
&gt;&gt; Hi All,<BR>
&gt;&gt;<BR>
&gt;&gt; I have a C application task called &quot;sswd&quot; on my Linux =
system, that<BR>
&gt;&gt; opens up the /var/log/audit/audit.log file every 5 seconds, and =
checks<BR>
&gt;&gt; to see if there are any new AVC denies.<BR>
&gt;&gt;<BR>
&gt;&gt; I have had this same task doing the same thing for the last few =
years<BR>
&gt;&gt; on a Linux system running selinux. And I have never seen these =
events<BR>
&gt;&gt; in audit.log before complaining about the sswd task... I used =
to use<BR>
&gt;&gt; older selinux packages, and ran the Fedora Core 7 'strict' =
policy<BR>
&gt;&gt; together with some custom policies.<BR>
&gt;&gt;<BR>
&gt;&gt; Recently we upgraded our SELinux packages to the very latest =
(similar<BR>
&gt;&gt; to Fedora 12), and we are using Refpolicy as a base policy.<BR>
&gt;&gt;<BR>
&gt;&gt; In the /var/log/audit/audit.log file, I see the following event =
pop up<BR>
&gt;&gt; every 5 seconds, and I am guessing its because &quot;sswd&quot; =
tries to open up<BR>
&gt;&gt; the audit.log file every 5 seconds for reading.<BR>
&gt;&gt;<BR>
&gt;&gt; 1. Can you help me understand what this event is really =
saying?<BR>
&gt;&gt; 2. I have already taken the audit.log file, and used =
audit2allow to<BR>
&gt;&gt; generate any allow rules necessary, but it didnt help to get =
rid of<BR>
&gt;&gt; this particular event.<BR>
&gt;&gt; 3. Can I add any specific policy allow lines or transition =
rules in my<BR>
&gt;&gt; custom policy files to get rid of this repeated event ?<BR>
&gt;&gt;<BR>
&gt;&gt; Thanks in advance.<BR>
&gt;&gt;<BR>
&gt;&gt; The event that pops up every 5 seconds in audit.log is:<BR>
&gt;&gt;<BR>
&gt;&gt; type=3DSYSCALL msg=3Daudit(1262874266.422:260): arch=3D14 =
syscall=3D5<BR>
&gt;&gt; success=3Dyes exit=3D24 a0=3D1002b9e4 a1=3D0 a2=3D1b6 a3=3D1b6 =
items=3D1 ppid=3D2463<BR>
&gt;&gt; pid=3D2794 auid=3D4294967295 uid=3D0 gid=3D601 euid=3D0 =
suid=3D0 fsuid=3D0 egid=3D601<BR>
&gt;&gt; sgid=3D601 fsgid=3D601 tty=3D(none) ses=3D4294967295 =
comm=3D&quot;sswd&quot;<BR>
&gt;&gt; exe=3D&quot;/usr/app/bin/sswd&quot; =
subj=3Dsystem_u:system_r:init_t:s0-s15:c0.c255<BR>
&gt;&gt; key=3D&quot;LOG_audit&quot;<BR>
&gt;&gt; type=3DCWD msg=3Daudit(1262874266.422:260):&nbsp; =
cwd=3D&quot;/data&quot;<BR>
&gt;&gt; type=3DPATH msg=3Daudit(1262874266.422:260): item=3D0<BR>
&gt;&gt; name=3D&quot;/var/log/audit/audit.log&quot; inode=3D2061 =
dev=3Dfd:07 mode=3D0100600<BR>
&gt;&gt; ouid=3D0 ogid=3D0 rdev=3D00:00<BR>
&gt;&gt; obj=3Dsystem_u:object_r:auditd_log_t:s15:c0.c255<BR>
&gt;<BR>
&gt; That's your audit configuration (/etc/audit/audit.rules), not =
SELinux.<BR>
&gt; You have an audit rule that says to log all access to the audit =
log<BR>
&gt; file, presumably copied from the sample audit rules for the CAPP or =
LSPP<BR>
&gt; configurations.&nbsp; Looks like this in audit.rules:<BR>
&gt; -w /var/log/audit/ -k LOG_audit<BR>
&gt;<BR>
&gt; I think you'd be better off using audispd to dispatch audit events =
to<BR>
&gt; your program rather than directly reading audit.log yourself.<BR>
&gt;&gt;<BR>
&gt;&gt; root@hapWibbSc2:/var/log/audit# ps -eZ | grep sswd<BR>
&gt;&gt; system_u:system_r:init_t:s0-s15:c0.c255 2781 ? 00:00:00 =
sswd<BR>
&gt;&gt;<BR>
&gt;&gt; root@hapWibbSc2:/var/log/audit# cd /usr/app/bin<BR>
&gt;&gt; root@hapWibbSc2:/usr/app/bin# ls -l sswd<BR>
&gt;&gt; -rwxrwxr-x 1 root root 217204 Jan&nbsp; 1 07:49 sswd<BR>
&gt;&gt;<BR>
&gt;&gt; root@hapWibbSc2:/usr/app/bin# cd /var/log/audit/<BR>
&gt;&gt; root@hapWibbSc2:/var/log/audit#<BR>
&gt;&gt; root@hapWibbSc2:/var/log/audit# ls -lZ<BR>
&gt;&gt; -rw-------&nbsp; root root =
system_u:object_r:auditd_log_t:s15:c0.c255<BR>
&gt;&gt; audit.log<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
You probably want to steal the code in sedisp in the setroubleshoot =
package, since this is exactly what it does.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA8FDD.4EBE7307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
