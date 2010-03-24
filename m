Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2OH8TiP027996
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 13:08:29 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2OH847Y028395
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 17:08:04 GMT
Message-ID: <4BAA4707.9080803@redhat.com>
Date: Wed, 24 Mar 2010 13:08:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <karlwmacmillan@gmail.com>
Subject: Re: sepolgen unit tests fail
References: <4BAA3B96.9000706@manicmethod.com>
In-Reply-To: <4BAA3B96.9000706@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------010805000304000106020108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010805000304000106020108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch to fix unit test.

--------------010805000304000106020108
Content-Type: text/plain;
 name="sepolgen_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sepolgen_test.patch"

diff --git a/sepolgen/tests/test_access.py b/sepolgen/tests/test_access.py
index 16d856e..fec699e 100644
--- a/sepolgen/tests/test_access.py
+++ b/sepolgen/tests/test_access.py
@@ -82,8 +82,8 @@ class TestAccessVector(unittest.TestCase):
         a.obj_class = "file"
         a.perms.update(["read", "write"])
 
-        self.assertEquals(str(a), "allow foo bar : file { read write };")
-        self.assertEquals(a.to_string(), "allow foo bar : file { read write };")
+        self.assertEquals(str(a), "allow foo bar:file { read write };")
+        self.assertEquals(a.to_string(), "allow foo bar:file { read write };")
 
     def test_cmp(self):
         a = access.AccessVector()
diff --git a/sepolgen/tests/test_interfaces.py b/sepolgen/tests/test_interfaces.py
index 674ccb9..b589bdf 100644
--- a/sepolgen/tests/test_interfaces.py
+++ b/sepolgen/tests/test_interfaces.py
@@ -86,17 +86,17 @@ interface(`files_search_usr',`
 	')
 
 	allow $1 usr_t:dir search;
-        allow { domain $1 } { usr_t usr_home_t } : { file dir } { read write getattr };
+        allow { domain $1 } { usr_t usr_home_t }:{ file dir } { read write getattr };
         typeattribute $1 file_type;
 
         if (foo) {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         }
 
         if (bar) {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         } else {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         }
 ')
 
@@ -135,8 +135,8 @@ interface(`foo',`
    gen_require(`
        type usr_t;
    ')
-   allow $1 usr_t : dir { create add_name };
-   allow $1 usr_t : file { read write };
+   allow $1 usr_t:dir { create add_name };
+   allow $1 usr_t:file { read write };
 ')
 """
 
@@ -145,16 +145,16 @@ interface(`foo',`
    gen_require(`
        type usr_t;
    ')
-   allow $1 usr_t : dir { create add_name };
-   allow $1 usr_t : file { read write };
+   allow $1 usr_t:dir { create add_name };
+   allow $1 usr_t:file { read write };
 ')
 
 interface(`map', `
    gen_require(`
        type bar_t;
    ')
-   allow $1 bar_t : file read;
-   allow $2 bar_t : file write;
+   allow $1 bar_t:file read;
+   allow $2 bar_t:file write;
 
    foo($2)
 ')
@@ -163,9 +163,9 @@ interface(`hard_map', `
    gen_require(`
       type baz_t;
    ')
-   allow $1 baz_t : file getattr;
-   allow $2 baz_t : file read;
-   allow $3 baz_t : file write;
+   allow $1 baz_t:file getattr;
+   allow $2 baz_t:file read;
+   allow $3 baz_t:file write;
 
    map($1, $2)
    map($2, $3)
diff --git a/sepolgen/tests/test_matching.py b/sepolgen/tests/test_matching.py
index 63e89ed..2282eca 100644
--- a/sepolgen/tests/test_matching.py
+++ b/sepolgen/tests/test_matching.py
@@ -98,16 +98,16 @@ interface(`foo',`
    gen_require(`
        type usr_t;
    ')
-   allow $1 usr_t : dir { create add_name };
-   allow $1 usr_t : file { read write };
+   allow $1 usr_t:dir { create add_name };
+   allow $1 usr_t:file { read write };
 ')
 
 interface(`map', `
    gen_require(`
        type bar_t;
    ')
-   allow $1 bar_t : file read;
-   allow $2 bar_t : file write;
+   allow $1 bar_t:file read;
+   allow $2 bar_t:file write;
 
    foo($2)
 ')
@@ -116,9 +116,9 @@ interface(`hard_map', `
    gen_require(`
       type baz_t;
    ')
-   allow $1 baz_t : file getattr;
-   allow $2 baz_t : file read;
-   allow $3 baz_t : file write;
+   allow $1 baz_t:file getattr;
+   allow $2 baz_t:file read;
+   allow $3 baz_t:file write;
 
    map($1, $2)
    map($2, $3)
diff --git a/sepolgen/tests/test_refparser.py b/sepolgen/tests/test_refparser.py
index c5f7278..3fe6d79 100644
--- a/sepolgen/tests/test_refparser.py
+++ b/sepolgen/tests/test_refparser.py
@@ -37,17 +37,17 @@ interface(`files_search_usr',`
 	')
 
 	allow $1 usr_t:dir search;
-        allow { domain $1 } { usr_t usr_home_t } : { file dir } { read write getattr };
+        allow { domain $1 } { usr_t usr_home_t }:{ file dir } { read write getattr };
         typeattribute $1 file_type;
 
         if (foo) {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         }
 
         if (bar) {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         } else {
-           allow $1 foo : bar baz;
+           allow $1 foo:bar baz;
         }
 ')
 

--------------010805000304000106020108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
