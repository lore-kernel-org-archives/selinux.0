Subject: Re: Interesting reading on exec* access checks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200512121703.jBCH3eEg017497@mms-r00.iijmio.jp>
References: <4398A5AD.2010701@redhat.com>
	 <200512121703.jBCH3eEg017497@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 12:27:07 -0500
Message-Id: <1134408427.7305.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-12-12 at 12:03 -0500, Yuichi Nakamura wrote:
> Daniel J Walsh wrote:
> > http://people.redhat.com/drepper/selinux-mem.html
> I have basic question about these permissions.
> Fedora Core already have "Exec Shield" to prevent execution of malicious code on memory.
> I can not understand relationship between exec shield and these permissions.
> What is good point of these permissions?
> In other words, 
> I would like to know 
> "Attack that can not be prevented  by exec shield, 
>  but can be prevented by these permissions(exec* permissions)".
> 
> Does anyone know ?

exec-shield is a mechanism that approximates NX support, but does not
define policy, so it cannot differentiate between a legitimate
application request for executable memory from the same request induced
by malicious code.  The SELinux exec* checks provide a way to apply
policy control over what processes can mmap/mprotect memory with
PROT_EXEC.  With just exec-shield, you lack protection against explicit
PROT_EXEC mmap/mprotect requests induced by malicious code; with just
SELinux exec* checking, you lack a mechanism to enforce NX (unless you
have hardware NX support), so the SELinux checking by itself is not very
useful.  exec-shield by itself provides some useful protection; coupled
with the SELinux checks, you get stronger protection.  Example of the
difference in paxtest output (with dummy function moved to outer scope)
before and after turning of the SELinux booleans for exec*:

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
<snip>
-Writable text segments                   : Vulnerable
+Writable text segments                   : Killed

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
