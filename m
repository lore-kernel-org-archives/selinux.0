From: "cheng weifang" <study_box@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: Trouble with Selinux package
Date: Wed, 07 Jan 2004 11:54:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <BAY2-F158WfBX8JKjfi000628e7@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello! Sorry to interrupt you. 
I have downloaded '2.4.23 kernel with SELinux patch applied' and 'SELinux 
Full Userland Archive' from http://www.nsa.gov/selinux. But when I build 
and install the SELinux-patched packages, there is something wrong with 
building 'coreutils-5.0-32.sel.src.rpm'. The following is the error 
message:
"
[root@cwf coreutils-5.0]# make
cd . && \
  /bin/sh /usr/src/redhat/BUILD/coreutils-5.0/config/missing --run 
automake-1.6
--gnits  Makefile
configure.ac:6: `automake requires `AM_CONFIG_HEADER', not 
`AC_CONFIG_HEADER'
configure.ac:9: require version 1.6b, but have 1.6.3
make: *** [Makefile.in] Error 1
[root@cwf coreutils-5.0]#
"
I guessed that it may be caused by version conflicts. I have read the 
README file.There is warning in it like this :
"WARNING:  If you modify files like configure.in, m4/*.m4, aclocal.m4,
or any Makefile.am, then don't be surprised if what gets regenerated no
longer works.  To make things work, you'll have to be using appropriate
versions of automake and autoconf.  As for what versions are `appropriate',
use the versions of

  * autoconf specified via AC_PREREQ in m4/jm-macros.m4
  * automake specified via AM_INIT_AUTOMAKE in configure.ac

Usually it's fine to use versions that are newer than those specified.°±

Then I got that the autoconf version is 2.56 form the line AC_PREREQ(2.56) 
in m4/jm-macros.m4. And the automake version specified in configure.ac  is 
AM_INIT_AUTOMAKE([1.6b gnits dist-bzip2]). But I don't clearly know what 
the automake version should be,because I cann't find the automake which is 
version 1.6b.
The automake on my Redhat 9.01 Linux is automake-1.6.3-5, and autoconf is 
autoconf-2.57-3. I think they both are newer then those specified, but why 
I get such errors? Can you help me?

I am waiting your answer. Thank you very much!

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
