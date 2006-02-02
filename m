Message-ID: <43E2769A.8040601@cornell.edu>
Date: Thu, 02 Feb 2006 16:16:10 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE][UTILS] Use PyList in bindings
References: <43E26F62.7010400@cornell.edu>
In-Reply-To: <43E26F62.7010400@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080100080603030905070003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080100080603030905070003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On the same note, this patch fixes a memory leak in the wrapper for 
things like:
semanage_context_to_string.

It's most likely language-portable (SWIG_FromCharPtr marks argument as 
const).


--------------080100080603030905070003
Content-Type: text/x-patch;
 name="libsemanage.python_string_leak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.python_string_leak.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-02-02 16:12:36.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-02-02 15:53:40.000000000 -0500
@@ -69,6 +69,7 @@
 
 %typemap(argout) char** {
 	$result = t_output_helper($result, SWIG_FromCharPtr(*$1));
+	free(*$1);
 }
 
 %typemap(in, numinputs=0) char ***(char **temp) {

--------------080100080603030905070003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
