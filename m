Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4P4PMUd000440
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2008 00:25:22 -0400
Received: from icweb02oc.mail2world.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4P4PL1R024432
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2008 04:25:21 GMT
From: "Takesi satoh" <t_mail@mail2Airport.com>
To: <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: netif and node check in RHEL5
Date: Sat, 24 May 2008 21:24:51 -0700
Message-ID: <049f01c8be1f$469877c0$036a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_04A0_01C8BDE4.9A399FC0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_04A0_01C8BDE4.9A399FC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello Paul,

Thank you for your additional information.
I understand node/netif functionality may go away in future.
I may have to think not to use node/netif functionality.
Thanks again!

Regards,
K


<-----Original Message----->

From: Paul Moore [paul.moore@hp.com]
Sent: 24/5/2008 3:08:39 AM
To: Takesi satoh
Cc: selinux@tycho.nsa.gov
Subject: Re: netif and node check in RHEL5

On Friday 23 May 2008 1:05:40 pm Takesi satoh wrote:
> Hello Paul,
>
> Thank you for your reply,
>
> > # echo 1 > /selinux/compat_net
>
> It works fine!
> Again, thank you very much.

I'm glad that solved your problem. I would still encourage you to 
transition your systems to secmark as the compat_net controls are 
considered "deprecated" and may go away in the future. In addition, 
you should notice better performance with secmark versus compat_net.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.
. 


Save on Cell Phones. Click Now!
<http://tagline.bidsystem.com/fc/Ioyw36XI3zggwuBSpKVxg8AwbQLP6qrdTFY8ykn
TNr0fPKabxoxAuu/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_04A0_01C8BDE4.9A399FC0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello Paul,<br>

<br>

Thank you for your additional information.<br>

I understand node/netif functionality may go away in future.<br>

I may have to think not to use node/netif functionality.<br>

Thanks again!<br>

<br>

Regards,<br>

K<br>

<br>

<br>

&lt;-----Original Message-----&gt;<br>

<br>

From: Paul Moore [paul.moore@hp.com]<br>

Sent: 24/5/2008 3:08:39 AM<br>

To: Takesi satoh<br>

Cc: selinux@tycho.nsa.gov<br>

Subject: Re: netif and node check in RHEL5<br>

<br>

On Friday 23 May 2008 1:05:40 pm Takesi satoh wrote:<br>

&gt; Hello Paul,<br>

&gt;<br>

&gt; Thank you for your reply,<br>

&gt;<br>

&gt; &gt; # echo 1 &gt; /selinux/compat_net<br>

&gt;<br>

&gt; It works fine!<br>

&gt; Again, thank you very much.<br>

<br>

I'm glad that solved your problem. I would still encourage you to <br>

transition your systems to secmark as the compat_net controls are <br>

considered "deprecated" and may go away in the future. In addition, <br>

you should notice better performance with secmark versus compat_net.<br>

<br>

-- <br>

paul moore<br>

linux @ hp<br>

<br>

--<br>

This message was distributed to subscribers of the selinux mailing list.<br>

If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>

the words "unsubscribe selinux" without quotes as the message.<br>

.
</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XI3zggwuBSpKVxg8AwbQLP6qrdTFY8yknTNr0fPKabxoxAuu/">Save on Cell Phones. Click Now!</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_04A0_01C8BDE4.9A399FC0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
