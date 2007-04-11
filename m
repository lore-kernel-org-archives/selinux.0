Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BKxfPD015270
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 16:59:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BKxdT2022969
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 20:59:40 GMT
Message-ID: <461D4C38.7000508@redhat.com>
Date: Wed, 11 Apr 2007 16:59:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
CC: =?ISO-8859-1?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>
Subject: Re: w3c-markup-validator policy files
References: <200704110042.23753.ville.skytta@iki.fi>
In-Reply-To: <200704110042.23753.ville.skytta@iki.fi>
Content-Type: multipart/mixed;
 boundary="------------060204030408020407020808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060204030408020407020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Policy for w3c-markup-validator, originally written by Ville Skytt=E4

Calling it w3c since other pages will be coming in the future.

Dan

--------------060204030408020407020808
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_w3c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_w3c.patch"

--- nsaserefpolicy/policy/modules/services/w3c.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/w3c.fc	2007-04-11 16:34:53.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/share/w3c-markup-validator(/.*)?		gen_context(system_u:object_r:httpd_w3c_validator_content_t,s0)
+/usr/share/w3c-markup-validator/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/w3c.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/w3c.if	2007-04-11 16:36:59.000000000 -0400
@@ -0,0 +1 @@
+## <summary>W3C</summary>
--- nsaserefpolicy/policy/modules/services/w3c.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/w3c.te	2007-04-11 16:36:14.000000000 -0400
@@ -0,0 +1,14 @@
+policy_module(w3c,1.2.1)
+
+apache_content_template(w3c_validator)
+
+sysnet_dns_name_resolve(httpd_w3c_validator_script_t)
+
+corenet_tcp_connect_ftp_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_ftp_port(httpd_w3c_validator_script_t)
+corenet_tcp_connect_http_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_http_port(httpd_w3c_validator_script_t)
+corenet_tcp_connect_http_cache_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_http_cache_port(httpd_w3c_validator_script_t)
+
+miscfiles_read_certs(httpd_w3c_validator_script_t)

--------------060204030408020407020808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
