Message-ID: <45C35E38.6070906@yahoo.co.uk>
Date: Fri, 02 Feb 2007 15:52:24 +0000
From: Richard Stock <richardbs2000@yahoo.co.uk>
Reply-To: richardbs2000@yahoo.co.uk
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Error thrown during binary policy compilation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'd be grateful for some help or at least a pointers in the right direction
as to why I get policy compilation errors on what seems like valid policy.
I'm pretty new to selinux policy so apologies if I'm missing something
totally obvious.

I'm developing a very small form-factor battery powered device. My
version of Linux is based around a Linux from Scratch 6.2 system with
quite a number of modifications to incorporate the selinux framework, 
tools, libs etc.  A work within a chrooted environment to develop the 
system but I have one problem that is causing me grief.
I'm using refpolicy20061212 to help in learning policy but for some 
reason every time I try to compile the refpolicy it throws syntax errors.

My system has the following selinux components:
libsepol-1.16.0
checkpolicy-1.34.0
libselinux-1.34.0
libsemanage-1.10.0
polycoreutils-1.34.1
refpolicy-20061212

By the look of things my error is throw during the compilation of 
policy.conf into the binary policy. I have executed:
checkpolicy policy.conf -o policy.21 through "gdb" and the error seems 
to occur at the call to "read_source_policy" in checkpolicy.c.

I realise that due to the custom nature of my OS this may be a tough
nut to crack but I'm reasonably new to selinux policy and I'm also not
a parser type of person so any help would be warmly received.

I follow the instructions from the tresys website and the command
"make install" fails with the following:

-----snip
Creating refpolicy policy.conf
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf tmp/global_bools.conf 
tmp/only_te_rules.conf tmp/all_post.conf > policy.conf
Compiling and installing refpolicy /etc/selinux/refpolicy/policy/policy.21
/usr/bin/checkpolicy policy.conf -o /etc/selinux/refpolicy/policy/policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/kernel/corenetwork.te:1409:ERROR 'syntax error' at token 
':' on line 7947:

allow corenet_unconfined_type node_type:node *;
checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/selinux/refpolicy/policy/policy.21] Error 1
root:/etc/selinux/refpolicy/src/policy#

-------snip end

I thought it may be something to do with yacc or lex so I update my 
system to use the same versions of yacc and lex as my FC6 host where the 
policy builds fine. Before I start drilling
into more detail with gdb can anyone provide some pointers.

FWIW. The system I'm developing is bootable, stable and seems happy to 
load a policy that
is compiled elsewhere.  For development purposes it would be easier to 
to compile the policy within my build image, which is where I hit the 
problem.

Many thanks
Richard




		
___________________________________________________________ 
Now you can scan emails quickly with a reading pane. Get the new Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
