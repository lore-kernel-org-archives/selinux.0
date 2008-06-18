Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5IEZHgQ010969
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 10:35:17 -0400
Received: from icweb02oc.mail2world.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5IEZGj3010461
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 14:35:16 GMT
From: "T S" <t_mail@mail2Airport.com>
To: <txtoth@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: Question about XACE/X-SELinux
Date: Wed, 18 Jun 2008 07:34:53 -0700
Message-ID: <068601c8d150$7893cc40$046a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0687_01C8D115.CC34F440"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0687_01C8D115.CC34F440
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

>> Hello,
>>
>> I just want to try functionalities X-SELinux, such as prohibiting cut
and
>> paste.
>> Since the below changelog(URL) says X-SELinux functionalities are
turned off
>> by default,
>> I think I need to turn on at first.
>> I appreciate someone tell me how to turn on.
>>> http://lwn.net/Articles/283539/
>>
>> I am using Fedora Core9, xorg-server-Xorg-1.4.99.902-3.20080612,
>> and GNOME( meaning just after FC9 and yum update).
>>
>> I thought X-SELinux functionalities are turned on by default in FC9,
>> so I tried the below steps.
>> 1) setsebool xserver_object_manager=true
>> 2) insert loadable module like below. because I was expecting
>> some avc logs were generated if I tried cut and paste.
>>
>>> policy_module(test, 1.0.0)
>>> gen_require(`
>>> attribute domain;
>>> class x_synthetic_event { send receive };
>>>')
>>>auditallow domain domain:x_synthetic_event {send receive};
>>
>> 3) setenforce 1
>> 4) reboot GNOME( init 3 and init 5)
>> 5) trying cut&paste from a window to others. No avclogs are found.
>> Only found "Loading extension SELinux" in /var/log/Xorg.0.org.
>>
>> I appreciate someone tell me what I am missing here.
>>
>> Regards,
>> K
>>
>>
>> Need cash? Click to get an emergency loan, bad credit ok
>>
>> _______________________________________________________________
>> Get the FREE email that has everyone talking at
http://www.mail2world.com
>> Unlimited Email Storage - POP3 - Calendar - SMS - Translator - Much
More!
>
>Add this to xorg.conf
>
>Section "Extensions"
>Option "SELinux" "Enable"
>EndSection
>
>Thr default enforcing state is Permissive.
>
>Add this to set Enforcing state in X
>
>Section "Module"
>SubSection "extmod"
>Option "SELinux Enforcing"
>EndSubSection
>EndSection
>
>Add this to have the X Enforcing mode track the system enforcing state
>
>Section "Module"
>SubSection "extmod"
>Option "SELinux TrackSystem"
>EndSubSection
>EndSection
>
>xdpyinfo will tell you if the SELinux extension is enabled.

It works! thanks!
.
Regards,
K



All is not lost! Click now for professional data recovery.
<http://tagline.bidsystem.com/fc/Ioyw36XJLjK4UhGstZZSQ3Hk0AZo6rvZS3retV8
f9VUsqNp68F5S4h/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0687_01C8D115.CC34F440
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
&gt;&gt; Hello,<br>

&gt;&gt;<br>

&gt;&gt; I just want to try functionalities X-SELinux, such as prohibiting cut and<br>

&gt;&gt; paste.<br>

&gt;&gt; Since the below changelog(URL) says X-SELinux functionalities are turned off<br>

&gt;&gt; by default,<br>

&gt;&gt; I think I need to turn on at first.<br>

&gt;&gt; I appreciate someone tell me how to turn on.<br>

&gt;&gt;&gt; http://lwn.net/Articles/283539/<br>

&gt;&gt;<br>

&gt;&gt; I am using Fedora Core9, xorg-server-Xorg-1.4.99.902-3.20080612,<br>

&gt;&gt; and GNOME( meaning just after FC9 and yum update).<br>

&gt;&gt;<br>

&gt;&gt; I thought X-SELinux functionalities are turned on by default in FC9,<br>

&gt;&gt; so I tried the below steps.<br>

&gt;&gt; 1) setsebool xserver_object_manager=true<br>

&gt;&gt; 2) insert loadable module like below. because I was expecting<br>

&gt;&gt; some avc logs were generated if I tried cut and paste.<br>

&gt;&gt;<br>

&gt;&gt;&gt; policy_module(test, 1.0.0)<br>

&gt;&gt;&gt; gen_require(`<br>

&gt;&gt;&gt; attribute domain;<br>

&gt;&gt;&gt; class x_synthetic_event { send receive };<br>

&gt;&gt;&gt;')<br>

&gt;&gt;&gt;auditallow domain domain:x_synthetic_event {send receive};<br>

&gt;&gt;<br>

&gt;&gt; 3) setenforce 1<br>

&gt;&gt; 4) reboot GNOME( init 3 and init 5)<br>

&gt;&gt; 5) trying cut&paste from a window to others. No avclogs are found.<br>

&gt;&gt; Only found "Loading extension SELinux" in /var/log/Xorg.0.org.<br>

&gt;&gt;<br>

&gt;&gt; I appreciate someone tell me what I am missing here.<br>

&gt;&gt;<br>

&gt;&gt; Regards,<br>

&gt;&gt; K<br>

&gt;&gt;<br>

&gt;&gt;<br>

&gt;&gt; Need cash? Click to get an emergency loan, bad credit ok<br>

&gt;&gt;<br>

&gt;&gt; _______________________________________________________________<br>

&gt;&gt; Get the FREE email that has everyone talking at http://www.mail2world.com<br>

&gt;&gt; Unlimited Email Storage &#8211 POP3 &#8211 Calendar &#8211 SMS &#8211 Translator &#8211 Much More!<br>

&gt;<br>

&gt;Add this to xorg.conf<br>

&gt;<br>

&gt;Section "Extensions"<br>

&gt;Option "SELinux" "Enable"<br>

&gt;EndSection<br>

&gt;<br>

&gt;Thr default enforcing state is Permissive.<br>

&gt;<br>

&gt;Add this to set Enforcing state in X<br>

&gt;<br>

&gt;Section "Module"<br>

&gt;SubSection "extmod"<br>

&gt;Option "SELinux Enforcing"<br>

&gt;EndSubSection<br>

&gt;EndSection<br>

&gt;<br>

&gt;Add this to have the X Enforcing mode track the system enforcing state<br>

&gt;<br>

&gt;Section "Module"<br>

&gt;SubSection "extmod"<br>

&gt;Option "SELinux TrackSystem"<br>

&gt;EndSubSection<br>

&gt;EndSection<br>

&gt;<br>

&gt;xdpyinfo will tell you if the SELinux extension is enabled.<br>

<br>

It works! thanks!<br>

.<br>

Regards,<br>

K<br>


</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XJLjK4UhGstZZSQ3Hk0AZo6rvZS3retV8f9VUsqNp68F5S4h/">All is not lost! Click now for professional data recovery.</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0687_01C8D115.CC34F440--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
