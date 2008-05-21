Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4LDc1nj013175
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 09:38:01 -0400
Received: from icweb02oc.mail2world.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4LDbxlF001768
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 13:38:00 GMT
From: "Takesi satoh" <t_mail@mail2Airport.com>
To: <selinux@tycho.nsa.gov>
Subject: netif and node check in RHEL5
Date: Wed, 21 May 2008 06:37:30 -0700
Message-ID: <0a1101c8bb47$d12c4270$036a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0A12_01C8BB0D.24CD6A70"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0A12_01C8BB0D.24CD6A70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

I wonder that whether node and netif are checked in RHEL5 or not.
I tried to add some auditallow sentences in RHEL4 at first.

> auditallow unconfined_t node_type: node *;
> auditallow unconfined_t netif_type:netif *;

and executeed some commands such as,
> nc -p -l 8888
> echo "testtest" | nc 127.0.0.1 8888

Then, SELinux generated granted logs such as,
> localhost kernel: audit(1190468263.024:250): avc: granted { tcp_send }
for pid=6057 comm="nc" name="bash" dev=dm-0 ino=686823
scontext=root:system_r:unconfind_t tcontext=root:system_r:node_t
tclass=node

I tried same thing in RHEL5. but no granted logs are found in
/var/log/audit/audit.log.
I created module like below, and after compiling the module, tried
"semodule -i test.pp".
> policy_module(test, 1.0.0)
> gen_require {
> attribute node_type;
> attribute netif_type;
> type unconfined_t;
> }
> auditallow unconfined_t node_type:node *;
> auditallow unconfined_t netif_type:netif *;
>
> ( fc and if file are empty.)

I thought subject domain was not unconfined_t, so I confirmed what user
security context was.
But I logined root( unconfined_t )

Anyway, Does SELinux in RHEL5 checks node and netif ? or just my
mistake?

Regards,
K



Take a perfect family vacation to Orlando. Click Here.
<http://tagline.bidsystem.com/fc/Ioyw36XIxjaEAYbNOPV0Zq9V2bkt0YOrGFBXvN6
j0K6aTh5Me2S2sL/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0A12_01C8BB0D.24CD6A70
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello,<br>

<br>

I wonder that whether node and netif are checked in RHEL5 or not.<br>

I tried to add some auditallow sentences in RHEL4 at first.<br>

<br>

&gt; auditallow unconfined_t node_type: node *;<br>

&gt; auditallow unconfined_t netif_type:netif *;<br>

<br>

and executeed some commands such as,<br>

&gt; nc -p -l 8888<br>

&gt; echo "testtest" | nc 127.0.0.1 8888<br>

<br>

Then, SELinux generated  granted logs such as,<br>

&gt; localhost kernel: audit(1190468263.024:250): avc:  granted  { tcp_send } for  pid=6057 comm="nc" name="bash" dev=dm-0 ino=686823 scontext=root:system_r:unconfind_t tcontext=root:system_r:node_t tclass=node<br>

<br>

I tried same thing in RHEL5. but no granted logs are found in /var/log/audit/audit.log.<br>

I created module like below, and after compiling the module, tried "semodule -i test.pp".<br>

&gt; policy_module(test, 1.0.0)<br>

&gt;      gen_require {<br>

&gt;            attribute node_type;<br>

&gt;            attribute netif_type;<br>

&gt;            type unconfined_t;<br>

&gt;       }<br>

&gt;       auditallow unconfined_t node_type:node *;<br>

&gt;       auditallow unconfined_t netif_type:netif *;<br>

&gt;<br>

&gt; ( fc and if file are empty.)<br>

<br>

I thought subject domain was not unconfined_t, so I confirmed what user security context was.<br>

But I logined root( unconfined_t )<br>

<br>

Anyway, Does SELinux in RHEL5 checks node and netif ?  or just my mistake?<br>

<br>

Regards,<br>

K<br>


</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XIxjaEAYbNOPV0Zq9V2bkt0YOrGFBXvN6j0K6aTh5Me2S2sL/">Take a perfect family vacation to Orlando. Click Here.</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0A12_01C8BB0D.24CD6A70--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
