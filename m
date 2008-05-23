Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4NH6JNX012643
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 13:06:19 -0400
Received: from icweb02oc.mail2world.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4NH6IKd013884
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 17:06:18 GMT
From: "Takesi satoh" <t_mail@mail2Airport.com>
To: <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: netif and node check in RHEL5
Date: Fri, 23 May 2008 10:05:40 -0700
Message-ID: <0a0001c8bcf7$3aa64ba0$036a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0A01_01C8BCBC.8E4773A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0A01_01C8BCBC.8E4773A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello Paul,

Thank you for your reply,
> # echo 1 > /selinux/compat_net
It works fine!
Again, thank you very much.

Regards,
K



<-----Original Message-----> 
>From: Paul Moore [paul.moore@hp.com]
>Sent: 22/5/2008 1:53:38 AM
>To: t_mail@mail2airport.com
>Cc: selinux@tycho.nsa.gov
>Subject: Re: netif and node check in RHEL5
>
>On Wednesday 21 May 2008 9:37:30 am Takesi satoh wrote:
>> I wonder that whether node and netif are checked in RHEL5 or not.
>
>Hello,
>
>I believe RHEL5 makes use of secmark controls instead of the node/netif
>checks (the RH folks can correct me if I am wrong). You can enable the 
>node/netif checks in place of secmark if you want by 
>enabling "compat_net" ...
>
> # echo 1 > /selinux/compat_net
>
>-- 
>paul moore
>linux @ hp
>.
> 


Click to make millions by owning your own franchise.
<http://tagline.bidsystem.com/fc/Ioyw36XIjJ7iSBZ3r8Nw2oFv47LqDSMeEA0KgJL
jwBELfau1cSYPrk/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0A01_01C8BCBC.8E4773A0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello Paul,<br>

<br>

Thank you for your reply,<br>

&gt; # echo 1 &gt; /selinux/compat_net<br>

It works fine!<br>

Again, thank you very much.<br>

<br>

Regards,<br>

K<br>

<br>

<br>

<br>

&lt;-----Original Message-----&gt; <br>

&gt;From: Paul Moore [paul.moore@hp.com]<br>

&gt;Sent: 22/5/2008 1:53:38 AM<br>

&gt;To: t_mail@mail2airport.com<br>

&gt;Cc: selinux@tycho.nsa.gov<br>

&gt;Subject: Re: netif and node check in RHEL5<br>

&gt;<br>

&gt;On Wednesday 21 May 2008 9:37:30 am Takesi satoh wrote:<br>

&gt;&gt; I wonder that whether node and netif are checked in RHEL5 or not.<br>

&gt;<br>

&gt;Hello,<br>

&gt;<br>

&gt;I believe RHEL5 makes use of secmark controls instead of the node/netif <br>

&gt;checks (the RH folks can correct me if I am wrong).  You can enable the <br>

&gt;node/netif checks in place of secmark if you want by <br>

&gt;enabling "compat_net" ...<br>

&gt;<br>

&gt; # echo 1 &gt; /selinux/compat_net<br>

&gt;<br>

&gt;-- <br>

&gt;paul moore<br>

&gt;linux @ hp<br>

&gt;.<br>

&gt;
</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XIjJ7iSBZ3r8Nw2oFv47LqDSMeEA0KgJLjwBELfau1cSYPrk/">Click to make millions by owning your own franchise.</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0A01_01C8BCBC.8E4773A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
