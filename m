Message-ID: <20040824192527.8742.qmail@web60006.mail.yahoo.com>
Date: Tue, 24 Aug 2004 12:25:27 -0700 (PDT)
From: Justin Friel <capn_shoe@yahoo.com>
Subject: Trouble building Policy-1.16
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I am having a hard time getting policy-1.16 to compile
on a "Linux from scratch" system.  When I try to
compile the strict policy, I get the following output:

...
/usr/bin/checkpolicy -o policy.18 policy.conf
/usr/bin/checkpolicy:  loading policy configuration
from policy.conf
types/file.te:92:ERROR 'syntax error' at token ':f' on
line 3066:
allow auth shadow_t:file { getattr read };
type shadow_t, file_type;
/usr/bin/checkpolicy:  error(s) encountered while
parsing configuration
make: *** [policy.18] Error 1

Is this a problem with checkpolicy, m4 or the policy
package itself?  All of the other packages (the
patched kernel, libselinux-1.16, libsepol-1.0,
checkpolicy-1.16 and policycoreutils-1.16) compiled
without error, although checkpolicy gave a few
warnings during compilation.

I'm entirely new to SELinux, so I'm not really sure
where to start.  Any help is appreciated.

Thanks


		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
