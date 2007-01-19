Message-ID: <45B1400F.2010908@mentalrootkit.com>
Date: Fri, 19 Jan 2007 17:02:55 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: vin@netwosix.org
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: installation from scratch problems
References: <1169207960.8700.19.camel@zeroKnowledge>	 <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil> <1169243300.26086.5.camel@zeroKnowledge>
In-Reply-To: <1169243300.26086.5.camel@zeroKnowledge>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vincenzo Ciaglia wrote:
> Il giorno ven, 19/01/2007 alle 07.48 -0500, Stephen Smalley ha scritto:
> 
>> The current libselinux depends on thread local storage (tls) support,
>> which exists in glibc 2.4.  See the link below for a workaround patch
>> used by the Debian folks:
>> http://marc.theaimsgroup.com/?l=selinux&m=115807948020898&w=2
>>
>> Also, I would tend to suggest updating to stable branch that we just
>> created in the sourceforge svn repo, as that will be the basis for the
>> next nsa.gov/selinux stable release.  But that won't change the
>> situation wrt to tls support.  
>>
>> $ svn co https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0 selinux-stable
> 
> Thank you! I solved the problems. I used the debian's patch, recompiled
> gcc and glibc with tls support

Only one of these is necessary - not both. Doesn't hurt, of course, but 
it may be easier to not have to worry with the patch if you have tls 
support.

  and i used the userland packages from the
> svn repo.
> 
> Now i can install libselinux, libsemanage, libsepol and checkpolicy but
> i get this error with the latest package to compile: policycoreutils
> 
> Here the output:
> 
> **********************************************
> # cd policycoreutils/
> # make
> make[1]: Entering directory
> `/root/selinux-stable/policycoreutils/setfiles'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory
> `/root/selinux-stable/policycoreutils/setfiles'
> make[1]: Entering directory
> `/root/selinux-stable/policycoreutils/semanage'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory
> `/root/selinux-stable/policycoreutils/semanage'
> make[1]: Entering directory
> `/root/selinux-stable/policycoreutils/load_policy'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory
> `/root/selinux-stable/policycoreutils/load_policy'
> make[1]: Entering directory
> `/root/selinux-stable/policycoreutils/newrole'
> cc -Werror -Wall -W -DVERSION=\"1.34.0\"  -I/usr/include -DUSE_NLS
> -DLOCALEDIR="\"/usr/share/locale\"" -DPACKAGE="\"policycoreutils\""
> -D_XOPEN_SOURCE=500    newrole.c  -lselinux -lsepol -L/usr/lib -lcrypt
> -o newrole
> cc1: warnings being treated as errors
> newrole.c: In function 'main':
> newrole.c:947: warning: unused variable 'rc'
> make[1]: *** [newrole] Error 1
> make[1]: Leaving directory
> `/root/selinux-stable/policycoreutils/newrole'
> make: *** [all] Error 1
> **********************************************
> 

Just a warning. Upstream selinux doesn't treat warnings as errors so 
occasionally they creep in. You should back out whatever caused -Werror 
to be added to your compile flags.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
