Message-ID: <48A5B57E.7020001@windriver.com>
Date: Fri, 15 Aug 2008 12:57:34 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: file_contexts duplicates
References: <48A595CC.2020508@windriver.com> <1218819041.29535.272.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1218819041.29535.272.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-08-15 at 10:42 -0400, Vikram Ambrose wrote:
>   
>> I have a problem in which file_contexts gets to 11mb (152kb unique) 
>> because of duplicates.
>>
>> Using selinux-svn2950 and refpolicy-svn2780 I built the standard policy
>> distro=redhat
>> unknown perms=deny
>> no direct admin init
>>
>> Now using the .pp files that got installed into /usr/share/selinux/standard
>>
>> I attempted to create a 2nd policy by hand using semodule.
>>
>> # export NAME=vikram
>> # mkdir -v -p \
>>    /etc/selinux/$NAME/modules/active \
>>    /etc/selinux/$NAME/contexts/files \
>>    /etc/selinux/$NAME/policy
>> # cd /usr/share/selinux/standard
>> # semodule -v -n -s $NAME -b base.pp $(for i in *.pp ; do  if [ "$i" != 
>> "base.pp" ] ; then echo -n "-i $i "; fi; done)
>>
>> This command appears to run for eternity. But after investigation, it 
>> seems setfiles is getting stuck up reading file_contexts. And is 
>> relabeling the file system again and again because of the duplicate 
>> definitions.
>>
>> Shorting out setfiles lets the command complete in 30mins. ie 
>> Transaction return 0. However because the file_contexts is 11mb of 
>> duplicates. It cannot be used. Doing a:
>>
>> # sort /etc/selinux/$NAME/contexts/files/file_contexts | uniq > clean
>> # mv clean /etc/selinux/$NAME/contexts/files/file_contexts
>>
>> Produces a 152kb file.
>> Note: /etc/selinux/standard/context/files/file_contexts is 156kb
>>
>> Relabeling the file system now with the new 152kb file. Causes 
>> /usr/lib64 to get usr_t which causes massive denial at boot up. And 
>> eventually haults login.
>>
>> What in the world is going on? Where would I begin to debug these 
>> problems: 1) Duplicates in file_contexts and 2) Missing contexts
>>     
>
> Is there a reason you aren't doing this the usual way, e.g. by doing a
> make load from the refpolicy directory rather than manually trying to
> install the modules? 
Why not?
>  And why are you changing the NAME= part way
> through the install, from standard to vikram?
>   
I think you misunderstood, the name is not changing. standard is what 
was produced by refpolicy, It is also the running policy when the steps 
I mentioned are run. Please read my email again.
> I tried reproducing your steps above with the same revisions of the
> selinux toolchain and refpolicy on a x86_64 box with f10/rawhide as the
> base distribution, but it all ran fine for me and my file_contexts is a
> reasonable size (146956 bytes).
>
> To be precise, I did:
> svn co -r2950 http://selinux.svn.sourceforge.net/svnroot/selinux/trunk selinux
> cd selinux
> make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> cd ..
> svn co -r2780 http://oss.tresys.com/repos/refpolicy/trunk refpolicy
> cd refpolicy
> make conf
> make NAME=standard DISTRO=redhat MONOLITHIC=n install
> cd /usr/share/selinux/standard
>
> and then I ran the commands you showed above.  It completed without
> errors and produced a valid, reasonable size file_contexts file.
>
>   
Yes, this seems to be the consensus. For some reason my build tools dont 
seem to be doing their job quite right.

Oh and on another note, did you get a chance to see the new build system 
that I have proposed and mailed to the list?

Vikram

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
