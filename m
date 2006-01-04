Message-ID: <43BC2916.4000909@cornell.edu>
Date: Wed, 04 Jan 2006 14:59:18 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Also libsemanage does not seem to work when adding.
References: <43BC37D9.5010201@redhat.com> <43BC1DFA.5020106@cornell.edu> <43BC3BFA.4020606@redhat.com>
In-Reply-To: <43BC3BFA.4020606@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040307000700070208010703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040307000700070208010703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> libsemanage.parse_assert_space: missing whitespace 
> (/etc/selinux/targeted/modules/active/ports.local: 1):
> portcon tcp 123456 system_u:object_r:http_port_t:s0
> libsemanage.port_parse: could not parse port record
> libsemanage.dbase_file_cache: could not cache file database
> libsemanage.enter_ro: could not enter read-only section
> Segmentation fault
Fix for single ports parser attached - I had only tried ranges.
Not sure what's going on with this segfault - try to reproduce again, 
and make sure
that all rc values are checked before proceeding to the next semanage call.





--------------040307000700070208010703
Content-Type: text/x-patch;
 name="libsemanage.fix_ports_parser.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_ports_parser.diff"

diff -Naurp --exclude man --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2006-01-04 10:47:45.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2006-01-04 14:49:19.000000000 -0500
@@ -99,22 +99,29 @@ static int port_parse(
 	if (parse_fetch_int(handle, info, &low, '-') < 0)
 		goto err;
 
-	if (parse_skip_space(handle, info) < 0)
-		goto err;
+	/* If range (-) does not follow immediately, require a space 
+	 * In other words, the space here is optional, but only
+	 * in the ranged case, not in the single port case,
+	 * so do a custom test */
+	if (*(info->ptr) && *(info->ptr) != '-') {
+		if (parse_assert_space(handle, info) < 0)
+			goto err;
+	}
+
 	if (parse_optional_ch(info, '-') != STATUS_NODATA) {
 
 		if (parse_skip_space(handle, info) < 0)
 			goto err;	
 		if (parse_fetch_int(handle, info, &high, ' ') < 0)
 			goto err;
+		if (parse_assert_space(handle, info) < 0)
+			goto err;
 		semanage_port_set_range(port, low, high);
 	}
 	else 
 		semanage_port_set_port(port, low);
 
         /* Port context */
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {

--------------040307000700070208010703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
