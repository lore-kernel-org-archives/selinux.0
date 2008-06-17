Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HCogpc000573
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 08:50:42 -0400
Received: from icweb02oc.mail2world.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5HCofF0004866
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 12:50:42 GMT
From: "T S" <t_mail@mail2Airport.com>
To: <selinux@tycho.nsa.gov>
Subject: Question about XACE/X-SELinux
Date: Tue, 17 Jun 2008 05:50:17 -0700
Message-ID: <07a701c8d078$b15798a0$046a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_07A8_01C8D03E.04F8C0A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_07A8_01C8D03E.04F8C0A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

I just want to try functionalities X-SELinux, such as prohibiting cut
and paste.
Since the below changelog(URL) says X-SELinux functionalities are turned
off by default, 
I think I need to turn on at first. 
I appreciate someone tell me how to turn on.
> http://lwn.net/Articles/283539/

I am using Fedora Core9, xorg-server-Xorg-1.4.99.902-3.20080612,
and GNOME( meaning just after FC9 and yum update).

I thought X-SELinux functionalities are turned on by default in FC9,
so I tried the below steps.
1) setsebool xserver_object_manager=true
2) insert loadable module like below. because I was expecting
some avc logs were generated if I tried cut and paste.

> policy_module(test, 1.0.0)
> gen_require(`
> attribute domain;
> class x_synthetic_event { send receive };
>')
>auditallow domain domain:x_synthetic_event {send receive};

3) setenforce 1
4) reboot GNOME( init 3 and init 5)
5) trying cut&paste from a window to others. No avclogs are found.
Only found "Loading extension SELinux" in /var/log/Xorg.0.org.

I appreciate someone tell me what I am missing here.

Regards,
K



Need cash? Click to get an emergency loan, bad credit ok
<http://tagline.bidsystem.com/fc/Ioyw36XHxOdtlQEyiBy8w8bGOQx9ugfZFBGL7xG
NpWaG9Vx6r3wVdx/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_07A8_01C8D03E.04F8C0A0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello,<br>

<br>

I just want to try functionalities X-SELinux, such as prohibiting cut and paste.<br>

Since the below changelog(URL) says X-SELinux functionalities are turned off by default, <br>

I think I need to turn on at first. <br>

I appreciate someone tell me how to turn on.<br>

&gt; http://lwn.net/Articles/283539/<br>

<br>

I am using Fedora Core9, xorg-server-Xorg-1.4.99.902-3.20080612,<br>

and GNOME( meaning just after FC9 and yum update).<br>

<br>

I thought X-SELinux functionalities are turned on by default in FC9,<br>

so I tried the below steps.<br>

1) setsebool xserver_object_manager=true<br>

2) insert loadable module like below. because I was expecting<br>

some avc logs were generated if I tried cut and paste.<br>

<br>

&gt; policy_module(test, 1.0.0)<br>

&gt; gen_require(`<br>

&gt;      attribute domain;<br>

&gt;      class x_synthetic_event { send receive };<br>

&gt;')<br>

&gt;auditallow domain domain:x_synthetic_event {send receive};<br>

<br>

3) setenforce 1<br>

4) reboot GNOME( init 3 and init 5)<br>

5) trying cut&paste from a window to others. No avclogs are found.<br>

Only found "Loading extension SELinux" in /var/log/Xorg.0.org.<br>

<br>

I appreciate someone tell me what I am missing here.<br>

<br>

Regards,<br>

K<br>


</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XHxOdtlQEyiBy8w8bGOQx9ugfZFBGL7xGNpWaG9Vx6r3wVdx/">Need cash? Click to get an emergency loan, bad credit ok</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_07A8_01C8D03E.04F8C0A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
