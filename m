From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: max barwell <maxb@paradise.net.nz>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: libselinux.so: cannot open shared object file
Date: Thu, 4 Sep 2003 14:53:03 +1000
References: <1062637188.565.7.camel@orac.lite.net.nz>
In-Reply-To: <1062637188.565.7.camel@orac.lite.net.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309041453.03201.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Sep 2003 10:59, max barwell wrote:
> I am using debian sid, I compiled a 2.6.0-test4 kernel ready for use,
> and downloaded Colin Walters SElinux packages, during their install, and
> I'm not sure when as I wasn't watching, the install borked, and now when
> I try to do anything ie type ls, I get the error message
>
> error while loading shared libraries: libselinux.so: cannot open shared
> object file: No such file or directory
>
> what happened? can I fix this? anyone encountered this before?

It sounds like one of two things happened:

1)  The dependencies were not correct and you managed to install a coreutils 
package without the library package it should depend on.
2)  You are running SE Linux in enforcing mode and libselinux.so got the wrong 
type (can occur when an apt installation aborts).

For 1 you have to install the necessary package.

For 2 you have to relabel the file in question with a command like the 
following:
find /lib /usr/lib | setfiles -s -v /etc/selinux/file_contexts/file_contexts

Anyway your system is not as broken as you think.  If you have busybox-static 
installed (or can install it) then it will work fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
