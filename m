Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15913
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:56:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA29027
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 21:55:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA29023 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 21:55:00 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AF3B792457
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 07:56:31 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 816AB3CCE
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 23:55:57 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: net_contexts
Date: Thu, 25 Apr 2002 23:55:57 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9X851SHPAINX8MQ374EO"
Message-Id: <20020425215557.816AB3CCE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_9X851SHPAINX8MQ374EO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached my latest net_contexts file which ifdef's around all the port 
bindings.  I've moved the definitions for the port_type objects to the *.te 
files, so now if you remove a .te file then the policy compiled with that 
change will also not have any special settings for the TCP/UDP ports 
associated with that program.

In the case of port 8080 I used an ugly pair of ifdef's for squid and apache.

For the other files in my current sample policy see 
http://www.coker.com.au/selinux/policy.tgz

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_9X851SHPAINX8MQ374EO
Content-Type: text/plain;
  charset="us-ascii";
  name="net_contexts"
Content-Transfer-Encoding: base64
Content-Description: net_contexts
Content-Disposition: attachment; filename="net_contexts"

IyBGTEFTSwoKIwojIFNlY3VyaXR5IGNvbnRleHRzIGZvciBuZXR3b3JrIGVudGl0aWVzCiMgSWYg
bm8gY29udGV4dCBpcyBzcGVjaWZpZWQsIHRoZW4gYSBkZWZhdWx0IGluaXRpYWwgU0lEIGlzIHVz
ZWQuCiMKCiMKIyBQb3J0IG51bWJlcnMgKGRlZmF1bHQgPSBpbml0aWFsIFNJRCAncG9ydCcpCiMg
CiMgcHJvdG9jb2wgbnVtYmVyIGNvbnRleHQKIyBwcm90b2NvbCBsb3ctaGlnaCBjb250ZXh0CiMK
aWZkZWYoYGZ0cGQudGUnLCBgdGNwIDIxIHN5c3RlbV91Om9iamVjdF9yOmZ0cF9wb3J0X3QnKQpp
ZmRlZihgaW5ldGQudGUnLCBgdGNwIDIzIHN5c3RlbV91Om9iamVjdF9yOnRlbG5ldF9wb3J0X3Qn
KQppZmRlZihgc2VuZG1haWwudGUnLCBgdGNwIDI1IHN5c3RlbV91Om9iamVjdF9yOnNtdHBfcG9y
dF90JykKaWZkZWYoYGFwYWNoZS50ZScsIGB0Y3AgODAgIHN5c3RlbV91Om9iamVjdF9yOmh0dHBf
cG9ydF90JykKaWZkZWYoYHJsb2dpbmQudGUnLCBgdGNwIDUxMyBzeXN0ZW1fdTpvYmplY3Rfcjpy
bG9naW5fcG9ydF90JykKaWZkZWYoYHJzaGQnLCBgdGNwIDUxNCBzeXN0ZW1fdTpvYmplY3Rfcjpy
c2hfcG9ydF90JykKaWZkZWYoYGxwZC50ZScsIGB0Y3AgNTE1IHN5c3RlbV91Om9iamVjdF9yOnBy
aW50ZXJfcG9ydF90JykKaWZkZWYoYGN1cHMudGUnLCBgdGNwIDYzMSBzeXN0ZW1fdTpvYmplY3Rf
cjppcHBfcG9ydF90JykKaWZkZWYoYGFwYWNoZS50ZScsIGB0Y3AgODA4MCAgc3lzdGVtX3U6b2Jq
ZWN0X3I6aHR0cF9jYWNoZV9wb3J0X3QnLApgaWZkZWYoYHNxdWlkLnRlJywgYHRjcCA4MDgwICBz
eXN0ZW1fdTpvYmplY3RfcjpodHRwX2NhY2hlX3BvcnRfdCcpJykKaWZkZWYoYG5hbWVkLnRlJywg
YHVkcCA1MyBzeXN0ZW1fdTpvYmplY3RfcjpuYW1lZF9wb3J0X3QnKQppZmRlZihgcmFkaXVzLnRl
JywgYHVkcCAxNjQ1IHN5c3RlbV91Om9iamVjdF9yOnJhZGl1c19wb3J0X3QKdWRwIDE2NDYgc3lz
dGVtX3U6b2JqZWN0X3I6cmFkYWNjdF9wb3J0X3QKdWRwIDE4MTIgc3lzdGVtX3U6b2JqZWN0X3I6
cmFkaXVzX3BvcnRfdAp1ZHAgMTgxMyBzeXN0ZW1fdTpvYmplY3RfcjpyYWRhY2N0X3BvcnRfdCcp
CmlmZGVmKGAnLCBgdGNwIDI2Mjggc3lzdGVtX3U6b2JqZWN0X3I6ZGljdF9wb3J0X3QnKQoKCiMg
TmV0d29yayBpbnRlcmZhY2VzIChkZWZhdWx0ID0gaW5pdGlhbCBTSUQgJ25ldGlmJyBhbmQgJ25l
dG1zZycpCiMKIyBpbnRlcmZhY2UgbmV0aWZfY29udGV4dCBkZWZhdWx0X21zZ19jb250ZXh0CiMK
bG8gc3lzdGVtX3U6b2JqZWN0X3I6bmV0aWZfbG9fdCBzeXN0ZW1fdTpvYmplY3RfcjpuZXRtc2df
bG9fdApldGgwIHN5c3RlbV91Om9iamVjdF9yOm5ldGlmX2V0aDBfdCBzeXN0ZW1fdTpvYmplY3Rf
cjpuZXRtc2dfZXRoMF90CmV0aDEgc3lzdGVtX3U6b2JqZWN0X3I6bmV0aWZfZXRoMV90IHN5c3Rl
bV91Om9iamVjdF9yOm5ldG1zZ19ldGgxX3QKCgojIE5vZGVzIChkZWZhdWx0ID0gaW5pdGlhbCBT
SUQgJ25vZGUnKQojCiMgYWRkcmVzcyBtYXNrIGNvbnRleHQKIwojIFRoZSBmaXJzdCBtYXRjaGlu
ZyBlbnRyeSBpcyB1c2VkLgojCjEyNy4wLjAuMSAyNTUuMjU1LjI1NS4yNTUgc3lzdGVtX3U6b2Jq
ZWN0X3I6bm9kZV9sb190CgojIE5GUyBzZXJ2ZXJzIChkZWZhdWx0ID0gaW5pdGlhbCBTSUQgJ25m
cycpCiMKIyBhZGRyZXNzIG1hc2sgZnNfY29udGV4dCBmaWxlX2NvbnRleHQKIyAKIyBUaGUgZmly
c3QgbWF0Y2hpbmcgZW50cnkgaXMgdXNlZC4KIwoxMC4zMy4xLjIgMjU1LjI1NS4yNTUuMjU1IHN5
c3RlbV91Om9iamVjdF9yOm5mc190IHN5c3RlbV91Om9iamVjdF9yOm5mc190CgojIEZMQVNLCg==

--------------Boundary-00=_9X851SHPAINX8MQ374EO--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
