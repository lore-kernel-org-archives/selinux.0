Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5QN7X72005299
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 19:07:33 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5QN9FqI022510
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 23:09:15 GMT
Received: from localhost.localdomain (unknown [192.168.2.5])
	by pobox.globalherald.net (Postfix) with ESMTP id C926F1FD066
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 21:37:25 -0400 (EDT)
Message-ID: <4C2687E7.5000705@globalherald.net>
Date: Sat, 26 Jun 2010 19:06:15 -0400
From: Joshua Kramer <josh@globalherald.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Rebuilding Modified Base Policy on RHEL6 (was  on-Computing Abstractions
 & An Issue Thereof)
References: <289557.20002.qm@web87003.mail.ird.yahoo.com> <4C2652F3.8010309@globalherald.net>
In-Reply-To: <4C2652F3.8010309@globalherald.net>
Content-Type: multipart/alternative;
 boundary="------------050105030301090903000302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050105030301090903000302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Is the method for rebuilding policy explained in the following guide, 
> still effective for RHEL6?
> http://danwalsh.livejournal.com/26428.html
>
Ok, so I followed the instructions on the noted page; specifically, near 
the bottom.  This line works to rebuild policy on RHEL6:

*make validate UNK_PERMS=allow NAME=strict TYPE=mcs DISTRO=redhat UBAC=n 
DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 base

However, if I do this*, to switch the build from strict to targeted:

cd ~/sources/BUILD/serefpolicy-VERSION
make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n 
DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 bare
make conf
make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n 
DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 conf

...the make breaks with this error:

Creating targeted base module base.conf
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf tmp/global_bools.conf 
tmp/only_te_rules.conf tmp/all_post.conf > base.conf
Compiling targeted base module
/usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
/usr/bin/checkmodule:  loading policy configuration from base.conf
policy/modules/kernel/domain.te":195:ERROR 'type selinux_config_t is not 
within scope' at token ';' on line 9468:
#line 195
     dontaudit domain selinux_config_t:dir { getattr search open };
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/base.mod] Error 1

It breaks even with a non-modified policy (i.e. install src.rpm and run 
this make command).

Do I need to do this, even if I only want to build a modified "targeted" 
version of the policy?  Is it "strict" by default?

Thanks,
-Josh

--------------050105030301090903000302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:4C2652F3.8010309@globalherald.net" type="cite">Is
the method for rebuilding policy explained in the following guide,
still effective for RHEL6?
  <br>
<a class="moz-txt-link-freetext" href="http://danwalsh.livejournal.com/26428.html">http://danwalsh.livejournal.com/26428.html</a>
  <br>
  <br>
</blockquote>
Ok, so I followed the instructions on the noted page; specifically,
near the bottom.&nbsp; This line works to rebuild policy on RHEL6:<br>
<br>
<strong>make validate UNK_PERMS=allow NAME=strict TYPE=mcs
DISTRO=redhat UBAC=n DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024
MCS_CATS=1024 base<br>
<br>
However, if I do this</strong>, to switch the build from strict to
targeted:<br>
<br>
<span>cd ~/sources/BUILD/serefpolicy-VERSION</span><br>
make
UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 bare<br>
make conf<br>
make
UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 conf<span><br>
</span><br>
...the make breaks with this error:<br>
<br>
Creating targeted base module base.conf<br>
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf &gt;
base.conf<br>
Compiling targeted base module<br>
/usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod<br>
/usr/bin/checkmodule:&nbsp; loading policy configuration from base.conf<br>
policy/modules/kernel/domain.te":195:ERROR 'type selinux_config_t is
not within scope' at token ';' on line 9468:<br>
#line 195<br>
&nbsp;&nbsp;&nbsp; dontaudit domain selinux_config_t:dir { getattr search open };<br>
/usr/bin/checkmodule:&nbsp; error(s) encountered while parsing configuration<br>
make: *** [tmp/base.mod] Error 1<br>
<br>
It breaks even with a non-modified policy (i.e. install src.rpm and run
this make command).<br>
<br>
Do I need to do this, even if I only want to build a modified
"targeted" version of the policy?&nbsp; Is it "strict" by default?<br>
<br>
Thanks,<br>
-Josh<br>
</body>
</html>

--------------050105030301090903000302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
