Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9K6RQNs027985
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 02:27:27 -0400 (EDT)
Received: from smtp.hivsa.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9K6OVN7024008
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 06:24:33 GMT
Received: from [10.38.244.66] (helo=[10.38.244.66])
	by smtp.hivsa.com with esmtp (Exim 4.50)
	id 1ESTmM-0000eZ-I9
	for selinux@tycho.nsa.gov; Thu, 20 Oct 2005 08:20:00 +0200
Message-ID: <4357372A.6070201@hivsa.com>
Date: Thu, 20 Oct 2005 08:20:26 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@hivsa.com
MIME-Version: 1.0
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Audit errors
References: <20051019223634.GC9176@thorium.jmh.mhn.de> <20051020032342.GA18453@vnl.com>
In-Reply-To: <20051020032342.GA18453@vnl.com>
Content-Type: multipart/alternative;
 boundary="------------070805050901000605060609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070805050901000605060609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Greetings fellow travellers.


Could someone please help me with the following errors:

*audit(1129788324.500:0): avc:  denied  { execute } for  pid=3105 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.501:0): avc:  denied  { execute } for  pid=3106 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.507:0): avc:  denied  { execute } for  pid=3107 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.510:0): avc:  denied  { execute } for  pid=3108 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.514:0): avc:  denied  { execute } for  pid=3109 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.517:0): avc:  denied  { execute } for  pid=3110 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.521:0): avc:  denied  { execute } for  pid=3111 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.522:0): avc:  denied  { execute } for  pid=3112 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.528:0): avc:  denied  { execute } for  pid=3113 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file
audit(1129788324.529:0): avc:  denied  { execute } for  pid=3114 
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872 
scontext=user_u:system_r:squid_t t
context=root:object_r:usr_t tclass=file*


These errors are from dmesg, and occured after compiling and installing 
squidclam from source.

Here is the output of selinuxconf:

[*root@shiva jay]# selinuxconfig
selinux state="enforcing"
policypath="/etc/selinux/targeted"
default_type_path="/etc/selinux/targeted/contexts/default_type"
default_context_path="/etc/selinux/targeted/contexts/default_contexts"
default_failsafe_context_path="/etc/selinux/targeted/contexts/failsafe_context"
binary_policy_path="/etc/selinux/targeted/policy/policy"
user_contexts_path="/etc/selinux/targeted/contexts/users/"
contexts_path="/etc/selinux/targeted/contexts"*

Output of uname -a:
*[root@shiva jay]# uname -a
Linux shiva 2.6.9-1.667smp #1 SMP Tue Nov 2 14:59:52 EST 2004 i686 i686 
i386 GNU/Linux*

Any help would be greatly appreciated.

God bless.

-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

Alternate email address: jayendren@mweb.co.za


--------------070805050901000605060609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Greetings fellow travellers.<br>
<br>
<br>
Could someone please help me with the following errors:<br>
<br>
<b>audit(1129788324.500:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3105
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.501:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3106
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.507:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3107
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.510:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3108
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.514:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3109
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.517:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3110
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.521:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3111
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.522:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3112
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.528:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3113
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file<br>
audit(1129788324.529:0): avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3114
exe=/usr/sbin/squid name=squidclamav dev=hda8 ino=185872
scontext=user_u:system_r:squid_t t<br>
context=root:object_r:usr_t tclass=file</b><br>
<br>
<br>
These errors are from dmesg, and occured after compiling and installing
squidclam from source.<br>
<br>
Here is the output of selinuxconf:<br>
<br>
[<b>root@shiva jay]# selinuxconfig<br>
selinux state="enforcing"<br>
policypath="/etc/selinux/targeted"<br>
default_type_path="/etc/selinux/targeted/contexts/default_type"<br>
default_context_path="/etc/selinux/targeted/contexts/default_contexts"<br>
default_failsafe_context_path="/etc/selinux/targeted/contexts/failsafe_context"<br>
binary_policy_path="/etc/selinux/targeted/policy/policy"<br>
user_contexts_path="/etc/selinux/targeted/contexts/users/"<br>
contexts_path="/etc/selinux/targeted/contexts"</b><br>
<br>
Output of uname -a:<br>
<b>[root@shiva jay]# uname -a<br>
Linux shiva 2.6.9-1.667smp #1 SMP Tue Nov 2 14:59:52 EST 2004 i686 i686
i386 GNU/Linux</b><br>
<br>
Any help would be greatly appreciated.<br>
<br>
God bless.<br>
<pre class="moz-signature" cols="72">-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

Alternate email address: <a class="moz-txt-link-abbreviated" href="mailto:jayendren@mweb.co.za">jayendren@mweb.co.za</a>
</pre>
</body>
</html>

--------------070805050901000605060609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
