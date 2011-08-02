Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p723AbhL020114
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 23:10:37 -0400
Received: from snt0-omc4-s11.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p723AZBn011934
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 03:10:36 GMT
Message-ID: <SNT139-W3302BB87F44CE395853050AB3B0@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_5ac415f8-35e2-424d-9b70-e5eacff0474f_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <martin.christian@secunet.com>, <selinux@tycho.nsa.gov>
Subject: RE: Howto transition socket
Date: Tue, 2 Aug 2011 03:10:34 +0000
In-Reply-To: <4E36CA2C.8080300@secunet.com>
References: <4E36CA2C.8080300@secunet.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_5ac415f8-35e2-424d-9b70-e5eacff0474f_
Content-Type: multipart/alternative;
	boundary="_a6bbf06c-052f-421d-8e06-c2e9a55b47c0_"

--_a6bbf06c-052f-421d-8e06-c2e9a55b47c0_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Martin,

> Date: Mon, 1 Aug 2011 17:45:48 +0200
> From: martin.christian@secunet.com
> To: selinux@tycho.nsa.gov
> Subject: Howto transition socket
> 
> Hi,
> 
> excuse this very basic question: How can I define a transition for a socket?
> 
> Let's assume I've got a process p with label u_t, denoted as p:u_t. The
> process opens a listening tcp socket s on port 80 (e. g. nc -l -p 80).
> As far as I understood, s would get the label from the process: s:u_t.
> However, I would like the socket to have label o_t. Hence, I define a
> transition:
> 
> (u, u) -> o
> 
> or in policy syntax;
> 
> type_transition u_t u_t:tcp_socket o_t;

Generally speaking, the type_transition rule for socket so that it would have a separate type than its creator works like this. However, other than this type_transition rule, you would also have to grant other necessary allow rules so that the creator could create and use this new socket type, such as:

allow u_t o_t : tcp_socket { create_socket_perms, sendto, .... };

and have the process role able to type with this socket type:

role <process's role> types o_t;

Then you could verify the socket type by the compute_create command, see below example.

I have attached my refpolicy patch to have the unix_dgram_socket created by syslogd_t to be labeled as syslogd_s_t, hope that helps :-)

Cheers,
Harry





	
	
	
	

     
[root/sysadm_r/s0@~]#
compute_create system_u:system_r:syslogd_t:s15:c0.c1023    
system_u:system_r:syslogd_t:s15:c0.c1023 unix_dgram_socket 

     
system_u:system_r:syslogd_s_t:s15:c0.c1023


     
[root/sysadm_r/s0@~]#


> 
> But this doesn't seem to work. Any ideas?
> 
> Regards,
> 
> Martin.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_a6bbf06c-052f-421d-8e06-c2e9a55b47c0_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Martin,<br><br><div>&gt; Date: Mon, 1 Aug 2011 17:45:48 +0200<br>&gt; From: martin.christian@secunet.com<br>&gt; To: selinux@tycho.nsa.gov<br>&gt; Subject: Howto transition socket<br>&gt; <br>&gt; Hi,<br>&gt; <br>&gt; excuse this very basic question: How can I define a transition for a socket?<br>&gt; <br>&gt; Let's assume I've got a process p with label u_t, denoted as p:u_t. The<br>&gt; process opens a listening tcp socket s on port 80 (e. g. nc -l -p 80).<br>&gt; As far as I understood, s would get the label from the process: s:u_t.<br>&gt; However, I would like the socket to have label o_t. Hence, I define a<br>&gt; transition:<br>&gt; <br>&gt; (u, u) -&gt; o<br>&gt; <br>&gt; or in policy syntax;<br>&gt; <br>&gt; type_transition u_t u_t:tcp_socket o_t;<br><br>Generally speaking, the type_transition rule for socket so that it would have a separate type than its creator works like this. However, other than this type_transition rule, you would also have to grant other ne!
 cessary allow rules so that the creator could create and use this new socket type, such as:<br><br>allow u_t o_t : tcp_socket { create_socket_perms, sendto, .... };<br><br>and have the process role able to type with this socket type:<br><br>role &lt;process's role&gt; types o_t;<br><br>Then you could verify the socket type by the compute_create command, see below example.<br><br>I have attached my refpolicy patch to have the unix_dgram_socket created by syslogd_t to be labeled as syslogd_s_t, hope that helps :-)<br><br>Cheers,<br>Harry<br><br><br>


	
	
	
	<style type="text/css">p { margin-bottom: 0.21cm; }</style>

<p style="margin-bottom: 0cm; text-decoration: none;">     
<font face="AR PL UMing HK, sans-serif"><font style="font-size: 9pt;" size="2">[root/sysadm_r/s0@~]#
compute_create system_u:system_r:syslogd_t:s15:c0.c1023    
system_u:system_r:syslogd_t:s15:c0.c1023 unix_dgram_socket </font></font>
</p>
<p style="margin-bottom: 0cm; text-decoration: none;">     
<font face="AR PL UMing HK, sans-serif"><font style="font-size: 9pt;" size="2">system_u:system_r:syslogd_s_t:s15:c0.c1023
</font></font>
</p>
<p style="margin-bottom: 0cm; text-decoration: none;">     
<font face="AR PL UMing HK, sans-serif"><font style="font-size: 9pt;" size="2">[root/sysadm_r/s0@~]#</font></font></p>
<br><br>&gt; <br>&gt; But this doesn't seem to work. Any ideas?<br>&gt; <br>&gt; Regards,<br>&gt; <br>&gt; Martin.<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_a6bbf06c-052f-421d-8e06-c2e9a55b47c0_--

--_5ac415f8-35e2-424d-9b70-e5eacff0474f_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="separate_sock_for_syslogd_t.patch"

Y29tbWl0IDM2NTA1MTYwZGMxMjc0ZTJiZWMyZmJiODU0YTM5YjhkMjg5MWQwOGMKQXV0aG9yOiBI
YXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPgpEYXRlOiAgIFRodSBGZWIgMjQg
MTY6MjM6NDIgMjAxMSArMDgwMAoKICAgIFNwZWNpZnkgYSBzZXBhcmF0ZSBzb2NrZXQgdHlwZSBm
b3Igc3lzbG9nZF90LgogICAgCiAgICBVc2UgYSB0eXBlX3RyYW5zaXRpb24gcnVsZSB0byBzcGVj
aWZ5IGEgc2VwYXJhdGUgdHlwZSBmb3IgdW5peF9kZ3JhbV9zb2NrZXQKICAgIG9iamVjdCBjcmVh
dGVkIGJ5IHN5c2xvZ2RfdCwgc28gdGhhdCB0aGUgc29ja2V0IHR5cGUgYWxvbmUgY291bGQgYmUg
YWRkZWQKICAgIHRvIHRoZSBtbHN0cnVzdGVkb2JqZWN0IGF0dHJidXRlIHRvIGF2b2lkIGJlbG93
IGVycm9yIG1lc3NhZ2U6CiAgICAKICAgIHR5cGU9MTQwMCBhdWRpdCgxMjk4NTM1MTAxLjY1NDo4
NjgpOiBhdmM6ICBkZW5pZWQgIHsgc2VuZHRvIH0gZm9yICBwaWQ9Mzg1IGNvbW09Imtsb2dkIiBw
YXRoPSIvZGV2L2xvZyIgc2NvbnRleHQ9c3lzdGVtX3U6b2JqZWN0X3I6a2xvZ2RfdDpzMCB0Y29u
dGV4dD1zeXN0ZW1fdTpvYmplY3RfcjpzeXNsb2dkX3Q6czE1OmMwLmMxMDIzIHRjbGFzcz11bml4
X2RncmFtX3NvY2tldAogICAgCiAgICBUaGlzIGhlbHBzIHRvIGF2b2lkIGFkZGluZyBzeXNsb2dk
X3QgdG8gdGhpcyBhdHRyaWJ1dGUgd2hpY2ggYWxzbyBpcyB0aGUKICAgIGxhYmVsIGZvciBhbGwg
c3lzbG9nZCdzIHByb2NmcyBjb250ZW50cy4KICAgIAogICAgQlRXLCBpbiBTRUxpbnV4IGtlcm5l
bCBkcml2ZXIgdGhlIHNlY3VyaXR5X3RyYW5zaXRpb25fc2lkKCkgc2hvdWxkIGJlCiAgICBjYWxs
ZWQgdG8gcXVlcnkgYWJvdmUgdHlwZV90cmFuc2l0aW9uIHJ1bGUgZm9yIHRoZSBuZXdseSBjcmVh
dGVkIHNvY2tldCwKICAgIHdoaWNoIHdpbGwgcmV0YWluIHRoZSBzYW1lIHVzZXIsIHJvbGUgYW5k
IE1MUyBhdHRyaWJ1dGUgYXMgaXRzIGNyZWF0b3IuCgpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVs
ZXMvc3lzdGVtL2xvZ2dpbmcuaWYgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbG9nZ2luZy5pZgpp
bmRleCA4MzFiOTA5Li4wY2FiMzJjIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0v
bG9nZ2luZy5pZgorKysgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbG9nZ2luZy5pZgpAQCAtNTI1
LDE0ICs1MjUsMTQgQEAgaW50ZXJmYWNlKGBsb2dnaW5nX2xvZ19maWxldHJhbnMnLGAKICMKIGlu
dGVyZmFjZShgbG9nZ2luZ19zZW5kX3N5c2xvZ19tc2cnLGAKIAlnZW5fcmVxdWlyZShgCi0JCXR5
cGUgc3lzbG9nZF90LCBkZXZsb2dfdDsKKwkJdHlwZSBzeXNsb2dkX3QsIHN5c2xvZ2Rfc190LCBk
ZXZsb2dfdDsKIAknKQogCiAJYWxsb3cgJDEgZGV2bG9nX3Q6bG5rX2ZpbGUgcmVhZF9sbmtfZmls
ZV9wZXJtczsKIAlhbGxvdyAkMSBkZXZsb2dfdDpzb2NrX2ZpbGUgd3JpdGVfc29ja19maWxlX3Bl
cm1zOwogCiAJIyB0aGUgdHlwZSBvZiBzb2NrZXQgZGVwZW5kcyBvbiB0aGUgc3lzbG9nIGRhZW1v
bgotCWFsbG93ICQxIHN5c2xvZ2RfdDp1bml4X2RncmFtX3NvY2tldCBzZW5kdG87CisJYWxsb3cg
JDEgc3lzbG9nZF9zX3Q6dW5peF9kZ3JhbV9zb2NrZXQgc2VuZHRvOwogCWFsbG93ICQxIHN5c2xv
Z2RfdDp1bml4X3N0cmVhbV9zb2NrZXQgY29ubmVjdHRvOwogCWFsbG93ICQxIHNlbGY6dW5peF9k
Z3JhbV9zb2NrZXQgY3JlYXRlX3NvY2tldF9wZXJtczsKIAlhbGxvdyAkMSBzZWxmOnVuaXhfc3Ry
ZWFtX3NvY2tldCBjcmVhdGVfc29ja2V0X3Blcm1zOwpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVs
ZXMvc3lzdGVtL2xvZ2dpbmcudGUgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbG9nZ2luZy50ZQpp
bmRleCBiNmVjNTk3Li42ODA0ZGNmIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0v
bG9nZ2luZy50ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbG9nZ2luZy50ZQpAQCAtNjUs
NiArNjUsMTMgQEAgdHlwZSBzeXNsb2dkX3Q7CiB0eXBlIHN5c2xvZ2RfZXhlY190OwogaW5pdF9k
YWVtb25fZG9tYWluKHN5c2xvZ2RfdCwgc3lzbG9nZF9leGVjX3QpCiAKKyMgUEZfVU5JWCBzb2Nr
ZXQgY3JlYXRlZCBieSBzeXNsb2dkLgorIyBBbnkgc29ja2V0IHdpbGwgcmV0YWluIHRoZSBzYW1l
IHVzZXIsIHJvbGUgYW5kIE1MUyBhdHRyaWJ1dGUgYXMKKyMgaXRzIGNyZWF0b3IsIHRodXMgdGhl
IGNyZWF0b3IncyByb2xlIG5lZWRzIHRvIHR5cGUgdGhlIHNvY2tldCB0eXBlLgordHlwZSBzeXNs
b2dkX3NfdDsKK3JvbGUgc3lzdGVtX3IgdHlwZXMgc3lzbG9nZF9zX3Q7CittbHNfdHJ1c3RlZF9v
YmplY3Qoc3lzbG9nZF9zX3QpCisKIHR5cGUgc3lzbG9nZF9pbml0cmNfZXhlY190OwogaW5pdF9z
Y3JpcHRfZmlsZShzeXNsb2dkX2luaXRyY19leGVjX3QpCiAKQEAgLTM2MCwxNSArMzY3LDE4IEBA
IGRvbnRhdWRpdCBzeXNsb2dkX3Qgc2VsZjpjYXBhYmlsaXR5IHN5c190dHlfY29uZmlnOwogIyBz
ZXRybGltaXQgZm9yIHN5c2xvZy1uZwogYWxsb3cgc3lzbG9nZF90IHNlbGY6cHJvY2VzcyB7IHNp
Z25hbF9wZXJtcyBzZXRwZ2lkIHNldHJsaW1pdCB9OwogIyByZWNlaXZlIG1lc3NhZ2VzIHRvIGJl
IGxvZ2dlZAotYWxsb3cgc3lzbG9nZF90IHNlbGY6dW5peF9kZ3JhbV9zb2NrZXQgY3JlYXRlX3Nv
Y2tldF9wZXJtczsKK2FsbG93IHN5c2xvZ2RfdCBzeXNsb2dkX3NfdDp1bml4X2RncmFtX3NvY2tl
dCBjcmVhdGVfc29ja2V0X3Blcm1zOwogYWxsb3cgc3lzbG9nZF90IHNlbGY6dW5peF9zdHJlYW1f
c29ja2V0IGNyZWF0ZV9zdHJlYW1fc29ja2V0X3Blcm1zOwotYWxsb3cgc3lzbG9nZF90IHNlbGY6
dW5peF9kZ3JhbV9zb2NrZXQgc2VuZHRvOworYWxsb3cgc3lzbG9nZF90IHN5c2xvZ2Rfc190OnVu
aXhfZGdyYW1fc29ja2V0IHNlbmR0bzsKIGFsbG93IHN5c2xvZ2RfdCBzZWxmOmZpZm9fZmlsZSBy
d19maWZvX2ZpbGVfcGVybXM7CiBhbGxvdyBzeXNsb2dkX3Qgc2VsZjp1ZHBfc29ja2V0IGNyZWF0
ZV9zb2NrZXRfcGVybXM7CiBhbGxvdyBzeXNsb2dkX3Qgc2VsZjp0Y3Bfc29ja2V0IGNyZWF0ZV9z
dHJlYW1fc29ja2V0X3Blcm1zOwogCiBhbGxvdyBzeXNsb2dkX3Qgc3lzbG9nX2NvbmZfdDpmaWxl
IHJlYWRfZmlsZV9wZXJtczsKIAorIyBQRl9VTklYIGRncmFtIHNvY2tldCBjcmVhdGVkIGJ5IHN5
c2xvZ2RfdCBsYWJlbGVkIGFzIHN5c2xvZ2Rfc190Cit0eXBlX3RyYW5zaXRpb24gc3lzbG9nZF90
IHN5c2xvZ2RfdDp1bml4X2RncmFtX3NvY2tldCBzeXNsb2dkX3NfdDsKKwogIyBDcmVhdGUgYW5k
IGJpbmQgdG8gL2Rldi9sb2cgb3IgL3Zhci9ydW4vbG9nLgogYWxsb3cgc3lzbG9nZF90IGRldmxv
Z190OnNvY2tfZmlsZSBtYW5hZ2Vfc29ja19maWxlX3Blcm1zOwogZmlsZXNfcGlkX2ZpbGV0cmFu
cyhzeXNsb2dkX3QsIGRldmxvZ190LCBzb2NrX2ZpbGUpCg==

--_5ac415f8-35e2-424d-9b70-e5eacff0474f_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
