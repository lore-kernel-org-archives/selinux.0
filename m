Subject: Re: file_contexts duplicates
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <48A595CC.2020508@windriver.com>
References: <48A595CC.2020508@windriver.com>
Content-Type: text/plain
Date: Fri, 15 Aug 2008 12:50:41 -0400
Message-Id: <1218819041.29535.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-15 at 10:42 -0400, Vikram Ambrose wrote:
> I have a problem in which file_contexts gets to 11mb (152kb unique) 
> because of duplicates.
> 
> Using selinux-svn2950 and refpolicy-svn2780 I built the standard policy
> distro=redhat
> unknown perms=deny
> no direct admin init
> 
> Now using the .pp files that got installed into /usr/share/selinux/standard
> 
> I attempted to create a 2nd policy by hand using semodule.
> 
> # export NAME=vikram
> # mkdir -v -p \
>    /etc/selinux/$NAME/modules/active \
>    /etc/selinux/$NAME/contexts/files \
>    /etc/selinux/$NAME/policy
> # cd /usr/share/selinux/standard
> # semodule -v -n -s $NAME -b base.pp $(for i in *.pp ; do  if [ "$i" != 
> "base.pp" ] ; then echo -n "-i $i "; fi; done)
> 
> This command appears to run for eternity. But after investigation, it 
> seems setfiles is getting stuck up reading file_contexts. And is 
> relabeling the file system again and again because of the duplicate 
> definitions.
> 
> Shorting out setfiles lets the command complete in 30mins. ie 
> Transaction return 0. However because the file_contexts is 11mb of 
> duplicates. It cannot be used. Doing a:
> 
> # sort /etc/selinux/$NAME/contexts/files/file_contexts | uniq > clean
> # mv clean /etc/selinux/$NAME/contexts/files/file_contexts
> 
> Produces a 152kb file.
> Note: /etc/selinux/standard/context/files/file_contexts is 156kb
> 
> Relabeling the file system now with the new 152kb file. Causes 
> /usr/lib64 to get usr_t which causes massive denial at boot up. And 
> eventually haults login.
> 
> What in the world is going on? Where would I begin to debug these 
> problems: 1) Duplicates in file_contexts and 2) Missing contexts

Is there a reason you aren't doing this the usual way, e.g. by doing a
make load from the refpolicy directory rather than manually trying to
install the modules?  And why are you changing the NAME= part way
through the install, from standard to vikram?

I tried reproducing your steps above with the same revisions of the
selinux toolchain and refpolicy on a x86_64 box with f10/rawhide as the
base distribution, but it all ran fine for me and my file_contexts is a
reasonable size (146956 bytes).

To be precise, I did:
svn co -r2950 http://selinux.svn.sourceforge.net/svnroot/selinux/trunk selinux
cd selinux
make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
cd ..
svn co -r2780 http://oss.tresys.com/repos/refpolicy/trunk refpolicy
cd refpolicy
make conf
make NAME=standard DISTRO=redhat MONOLITHIC=n install
cd /usr/share/selinux/standard

and then I ran the commands you showed above.  It completed without
errors and produced a valid, reasonable size file_contexts file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
