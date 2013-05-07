Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r478Yce0011458
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2013 04:34:38 -0400
Received: by mail-we0-f178.google.com with SMTP id q57so204610wes.9
        for <selinux@tycho.nsa.gov>; Tue, 07 May 2013 01:34:36 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id dq8sm1398162wib.1.2013.05.07.01.34.34
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 01:34:35 -0700 (PDT)
Date: Tue, 7 May 2013 10:33:42 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: What provides _policy?
Message-ID: <20130507083342.GA27823@siphos.be>
References: <20130501135544.GA21525@siphos.be>
 <20130503173926.GA22935@siphos.be>
 <5187DFB7.9050700@redhat.com>
 <20130506183828.GA26604@siphos.be>
 <5187FBF7.3090703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5187FBF7.3090703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 06, 2013 at 02:52:39PM -0400, Daniel J Walsh wrote:
> You might have found a bug in the current upstream,  we don't have this
> problem in Fedora.
> 
> I have attached the current fedora-sepolicy patch.

Apparently, the port information code (in info.c) assumes that MLS is
enabled (it calls apol_context_get_range) and errors out if no range is
found.

The below "patch" fixes that behavior.


diff -ur policycoreutils-2.1.14.orig/sepolicy/info.c policycoreutils-2.1.14/sepolicy/info.c
--- policycoreutils-2.1.14.orig/sepolicy/info.c	2013-05-01 15:49:48.424339861 +0200
+++ policycoreutils-2.1.14/sepolicy/info.c	2013-05-07 10:16:52.238205378 +0200
@@ -827,16 +827,14 @@
 		if (py_insert_string(dict, "type", type))
 			goto err;
 
-		if((range = apol_context_get_range(c)) == NULL) {
-			goto err;
-		}
-			
-		range_str = apol_mls_range_render(policydb, range);
-		if (range_str == NULL) {
-			goto err;
+		if((range = apol_context_get_range(c)) != NULL) {
+			range_str = apol_mls_range_render(policydb, range);
+			if (range_str == NULL) {
+				goto err;
+			}
+			if (py_insert_string(dict, "range", range_str))
+				goto err;
 		}
-		if (py_insert_string(dict, "range", range_str))
-			goto err;
 
 		if (py_insert_string(dict, "protocol", proto_str))
 			goto err;
Only in policycoreutils-2.1.14/sepolicy/sepolicy: __init__.pyc
diff -ur policycoreutils-2.1.14.orig/sepolicy/sepolicy/network.py policycoreutils-2.1.14/sepolicy/sepolicy/network.py
--- policycoreutils-2.1.14.orig/sepolicy/sepolicy/network.py	2013-05-01 15:49:48.423339861 +0200
+++ policycoreutils-2.1.14/sepolicy/sepolicy/network.py	2013-05-07 10:18:33.119205594 +0200
@@ -39,7 +39,11 @@
         else:
             portrecs [(i['type'], i['protocol'])] = [port]
 
-        portrecsbynum[(i['low'], i['high'],i['protocol'])] = (i['type'], i['range'])
+        if 'range' in i:
+            portrecsbynum[(i['low'], i['high'],i['protocol'])] = (i['type'], i['range'])
+        else:
+            portrecsbynum[(i['low'], i['high'],i['protocol'])] = (i['type'])
+
     return ( portrecs, portrecsbynum )
 portrecs, portrecsbynum = _gen_port_dict()
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
