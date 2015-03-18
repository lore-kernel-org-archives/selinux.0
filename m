Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2I95Vt3028473
 for <selinux@tycho.nsa.gov>; Wed, 18 Mar 2015 05:05:31 -0400
Date: Wed, 18 Mar 2015 05:05:08 -0400 (EDT)
From: Milos Malik <mmalik@redhat.com>
To: kuangjiou <kuangjiou@huawei.com>
Message-ID: <568659679.32020739.1426669508944.JavaMail.zimbra@redhat.com>
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB201569BC3@szxeml522-mbx.china.huawei.com>
References: <60ABE64B4BE4AC45964F1A967BA76CB201569BC3@szxeml522-mbx.china.huawei.com>
Subject: Re: Got some problem when using the type_transition, look for some
 helps! thank you!
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Sylar,

I forgot to mention that filename transition rules are not supported on RHEL-6.x. Based on the kernel version you provided I guess that you are not running RHEL-7.x, where the filename transition rules are supported.

# uname -srv
Linux 2.6.32-504.12.2.el6.i686 #1 SMP Sun Feb 1 12:14:25 EST 2015
# cat mypolicy.te 
policy_module(mypolicy,1.0)

require {
  type unconfined_t;
  type dentry_t;
  type file_t;
  class file { create };
}

type_transition unconfined_t dentry_t:file file_t "myfile";

# make -f /usr/share/selinux/devel/Makefile 
Compiling targeted mypolicy module
/usr/bin/checkmodule:  loading policy configuration from tmp/mypolicy.tmp
mypolicy.te":10:WARNING 'unrecognized character' at token '"' on line 3220:
type_transition unconfined_t dentry_t:file file_t "myfile";

mypolicy.te":10:ERROR 'syntax error' at token 'myfile' on line 3220:
type_transition unconfined_t dentry_t:file file_t "myfile";

/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/mypolicy.mod] Error 1
#

Milos Malik
SELinux QE person
BaseOS QE Security team
Brno, The Czech Republic

----- Original Message -----
> 
> 
> Hello,everyone!
> 
> 
> 
> I am try to use the new features of the type_transition that can support to
> determine the type of the new file by the name of this new file,And when I
> 
> 
> 
> use the type_transisiton in my own policy module like this:
> 
> 
> 
> type_transition unconfined_t dentry_t:file file_t myfile;
> 
> 
> 
> I got the error: 'syntax error' at token 'myfile' on line 1195:
> 
> 
> 
> It seems like didn't support the fifth parameter 'myfile', And I am using the
> checkmodule (version 2.3) to compile my policy module, but I am not sure
> 
> 
> 
> the the version of the linux kernel (Linux nkgcinwslx00671
> 2.6.32.12-0.7-default #1 SMP 2010-05-20 11:14:20 +0200 x86_64 x86_64 x86_64
> GNU/Linux) is
> 
> 
> 
> new enough to support this features.(I think the compiling should have
> nothing to do with the kernel?)
> 
> 
> 
> so, could anybody give me some suggestions to resolve this problem? I am
> looking forward to your replies! Thank you very much!
> 
> 
> 
> 
> 
> Sylar
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
