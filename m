Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7HFpdEc010589
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 11:51:39 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7HFp8UM007827
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 15:51:08 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n7HFjYJ5009547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 10:45:35 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n7HFeogs003014
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 10:40:50 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
References: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>
	<878whm1gr5.fsf@anzu.internal.golden-gryphon.com>
Date: Mon, 17 Aug 2009 10:40:50 -0500
In-Reply-To: <878whm1gr5.fsf@anzu.internal.golden-gryphon.com> (Manoj
	Srivastava's message of "Fri, 14 Aug 2009 11:50:54 -0500")
Message-ID: <87fxbq30u5.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 17 2009, Christopher J. PeBenito wrote:

> On Fri, 2009-08-14 at 11:50 -0500, Manoj Srivastava wrote:
>> On Fri, Aug 14 2009, Manoj Srivastava wrote:
>> 
>> >         I am running into an issue with sepolgen on Debian. Debian ships
>> >  more than one  version of the refpolicy, a default one, and a
>> >  MLS enabled one. So, the include files live in either
>> >  /usr/share/selinux/{default,mls}/include
>> >
>> >         sepolgen (in src/sepolgen/defaults.py) sets refpolicy_devel() to
>> >  a single location -- and thus, only one version of the security policy
>> >  may be supported. So, sepolgen-ifgen from policycoreutils can only work
>> >  with one policy, which may not be the one installed on the target
>> >  machine. Could this be made configurable, somehow? As far as I can
>> >  see, sepolgen's python library does not offer any way to set the value.
>> >
>> >         It would be nice if the location of the include directory could
>> >  be looked for from a PATH like variable setting, to make it easier for
>> >  distributions to ship more than one policy, or for end users to
>> >  experiment with other policies without have to overwrite the single
>> >  default. 
>> 
>>         Well, here is a kind of proof-of-concept patch (python is not my
>>  strong suit), and I have only tested in that it allows the package to
>>  compile, and the following code works:
> [...]
>>  def refpolicy_makefile():
>> -    return refpolicy_devel() + "/Makefile"
>> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
>> +    return chooser("Makefile")
>>  
>>  def headers():
>> -    return refpolicy_devel() + "/include"
>> -    
>> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
>> +    return chooser("include")
>> +
>
> Why are you making another config file rather than just get the policy
> name from /etc/selinux/config via selinux_getpolicytype()?

        This will work well for Debian, since the development files are
 installed under "/usr/share/selinux/" in a subdirectory named after the
 policy. I was not sure that this convention was followed in other
 distributions, though. While I am not certain, google implies that in
 fedora policy type is targeted, but the devel files do not live in
 /usr/share/selinux/targeted.[0]. Given that, perhaps it is better to
 let the user provide guidance about how to map the policy type to a
 directory? 

        Also, I must confess I had forgotten about this call.

        However, a patch with this is trivial, so an alternate patch
 follows. (Not sure this will work for fedora, so caveat emptor)

        manoj
[0] http://docs.fedoraproject.org/selinux-user-guide/f11/en-US/chap-Security-Enhanced_Linux-Working_with_SELinux.html

--8<---------------cut here---------------start------------->8---

If the user installs a policy whose development files do not live under
/usr/share/selinux/devel/include, sepolgen wqould not work. Debian, for
instance, installs under:
/usr/share/selinux/{default,mls}/include

This patch uses selinux_getpolicytype() to determine the policy type, and
assumes that there is one-on-one correspondence between policytype and
the directory the development files live in.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 src/sepolgen/defaults.py |    4 +++-
 src/sepolgen/module.py   |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/sepolgen/defaults.py b/src/sepolgen/defaults.py
index 45ce61a..85e5fb0 100644
--- a/src/sepolgen/defaults.py
+++ b/src/sepolgen/defaults.py
@@ -21,6 +21,8 @@
 Various default settings, including file and directory locations.
 """
 
+import selinux
+
 def data_dir():
     return "/var/lib/sepolgen"
 
@@ -31,7 +33,7 @@ def interface_info():
     return data_dir() + "/interface_info"
 
 def refpolicy_devel():
-    return "/usr/share/selinux/devel"
+    return "/usr/share/selinux/" + selinux.selinux_getpolicytype()[1]
 
 def refpolicy_makefile():
     return refpolicy_devel() + "/Makefile"
diff --git a/src/sepolgen/module.py b/src/sepolgen/module.py
index edd24c6..355c9b8 100644
--- a/src/sepolgen/module.py
+++ b/src/sepolgen/module.py
@@ -120,7 +120,7 @@ class ModuleCompiler:
         self.semodule_package = "/usr/bin/semodule_package"
         self.output = output
         self.last_output = ""
-        self.refpol_makefile = "/usr/share/selinux/devel/Makefile"
+        self.refpol_makefile = "/usr/share/selinux/" + selinux.selinux_getpolicytype()[1]  + "/Makefile"
         self.make = "/usr/bin/make"
 
     def o(self, str):
-- 
1.6.3.3


-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
