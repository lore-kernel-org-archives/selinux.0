Message-ID: <4A71AEB1.8010503@ii.net>
Date: Thu, 30 Jul 2009 22:31:13 +0800
From: Cliffe <cliffe@ii.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        slide@tresys.com
Subject: Re: Help with SELinux policy for Usability Study
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>	 <4A711890.2030101@ii.net> <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil> <4A71AD1A.5030406@ii.net>
In-Reply-To: <4A71AD1A.5030406@ii.net>
Content-Type: multipart/alternative;
 boundary="------------090207050001070907080300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090207050001070907080300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Cliffe wrote:
> Stephen Smalley wrote:
>> Sounds like you are getting a DBUS denial, so look for USER_AVC messages
>> e.g.
>> /sbin/ausearch -i -m USER_AVC.
>>     
> None there. It turns out they were in /var/log/messages so grep kwrite 
> /var/log/audit/audit.log | audit2allow >> kwrite.te did the trick. It 
> is strange that some AVCs go to /var/log/messages while others goto 
> /var/log/audit/audit.log
> Thanks for all your advice, it has helped a lot.
>
> Cliffe.
>   
(sorry, typo should read:)

grep kwrite /var/log/messages | audit2allow >> kwrite.te

did the trick.

--------------090207050001070907080300
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Cliffe wrote:
<blockquote cite="mid:4A71AD1A.5030406@ii.net" type="cite">
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
Stephen Smalley wrote:
  <blockquote
 cite="mid:1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
    <pre wrap="">Sounds like you are getting a DBUS denial, so look for USER_AVC messages
e.g.
/sbin/ausearch -i -m USER_AVC.
    </pre>
  </blockquote>
None there. It turns out they were in /var/log/messages so grep kwrite
/var/log/audit/audit.log | audit2allow &gt;&gt; kwrite.te
did the trick. It is strange that some AVCs go to /var/log/messages
while others goto /var/log/audit/audit.log<br>
  <pre wrap="">Thanks for all your advice, it has helped a lot.

Cliffe.
  </pre>
</blockquote>
(sorry, typo should read:)<br>
<pre wrap="">grep kwrite /var/log/messages | audit2allow &gt;&gt; kwrite.te</pre>
did the trick.<br>
</body>
</html>

--------------090207050001070907080300--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
