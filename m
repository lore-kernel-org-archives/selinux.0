Subject: Provide finer-grained booleans for execmem/execmod, please
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 14 Apr 2005 09:28:38 -0400
Message-Id: <1113485318.373.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'd like to again request finer-grained booleans for execmem and
execmod, possibly nested within the existing coarse-grained boolean, so
that we can allow it as needed for X and similar programs while denying
it elsewhere.  To show why this is useful, below is the diff of paxtest
(with nested function moved to global scope) results on the latest FC3
kernel with SELinux permissive vs. enforcing with the allow_execmem and
allow_execmod booleans set to 0.  The permissive output shows what is
being provided by exec-shield w/o SELinux, while the enforcing output
shows what added benefit is provided by the SELinux execmem/execmod
controls when they are denied to the domain in question.  Note that in
this test, /proc/sys/kernel/exec-shield was 1 and paxtest was built via
make generic.

--- paxtest-permissive.log	2005-04-11 14:14:23.000000000 -0400
+++ paxtest-enforcing.log	2005-04-11 14:14:23.000000000 -0400
@@ -9,18 +9,18 @@
 Executable data                          : Killed
 Executable heap                          : Killed
 Executable stack                         : Killed
-Executable anonymous mapping (mprotect)  : Vulnerable
-Executable bss (mprotect)                : Vulnerable
-Executable data (mprotect)               : Vulnerable
-Executable heap (mprotect)               : Vulnerable
-Executable shared library bss (mprotect) : Vulnerable
-Executable shared library data (mprotect): Vulnerable
-Executable stack (mprotect)              : Vulnerable
+Executable anonymous mapping (mprotect)  : Killed
+Executable bss (mprotect)                : Killed
+Executable data (mprotect)               : Killed
+Executable heap (mprotect)               : Killed
+Executable shared library bss (mprotect) : Killed
+Executable shared library data (mprotect): Killed
+Executable stack (mprotect)              : Killed
 Anonymous mapping randomisation test     : 8 bits (guessed)
-Heap randomisation test (ET_EXEC)        : 14 bits (guessed)
-Heap randomisation test (ET_DYN)         : 12 bits (guessed)
+Heap randomisation test (ET_EXEC)        : 13 bits (guessed)
+Heap randomisation test (ET_DYN)         : No randomisation
 Main executable randomisation (ET_EXEC)  : No randomisation
-Main executable randomisation (ET_DYN)   : 12 bits (guessed)
+Main executable randomisation (ET_DYN)   : No randomisation
 Shared library randomisation test        : No randomisation
 Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
 Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
@@ -30,4 +30,4 @@
 Return to function (memcpy, RANDEXEC)    : Vulnerable
 Executable shared library bss            : Vulnerable
 Executable shared library data           : Vulnerable
-Writable text segments                   : Vulnerable
+Writable text segments                   : Killed

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
