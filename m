Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6KLsQtd010141
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 17:54:26 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6KLsPrf005139
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 21:54:25 GMT
Received: by yw-out-1718.google.com with SMTP id 6so356711ywa.84
        for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:54:25 -0700 (PDT)
Message-ID: <4883B473.6070104@gmail.com>
Date: Sun, 20 Jul 2008 17:56:03 -0400
From: max <maximilianbianco@gmail.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux User Guide
References: <48803B08.1030205@redhat.com>
In-Reply-To: <48803B08.1030205@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:

> 
> There are a few SELinux books, but these are very technical. We want to 
> create a guide that people with no previous SELinux experience can use, 
> to allow them to do what they want without turning SELinux off.
> 

> 
> If anyone has any ideas about what they would like to see in the guide, 
> or any corrections to the current topics we would like to include, 
> please let us know. As well, user feedback and comments can be left at 
> <https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Feedback>. 
> A Fedora account (https://admin.fedoraproject.org/accounts/) is required 
> to use the Wiki - if you do not have one, please do not hesitate to mail 
> me directly, or respond to this thread.
> 

Here are a few ideas with comments in no particular order:

0 - *Reference material* - Not something many will probably dive into 
but necessary for completeness. Just some links to other sources of 
info. Like the IBM page :

> http://www.ibm.com/developerworks/linux/library/l-selinux/?ca=dgr-lnxw01SELinux

Even if there is no link directly to this page a small *Further Info* 
section like the Resources section at the bottom would still be useful, 
links to papers and web pages that can explain things in more detail if 
anyone is interested in finding out more of the nuts and bolts stuff.

Also perhaps links to any threads in the mailing list archives that help 
explain some of the concepts, these might be sprinkled about so they end 
up in relevant places. So if the section is about TE rules and there is 
a thread in the archives that was particularly good at explaining this 
or covers some key points then drop a link to the relevant thread there 
as additional reference or draw useful examples from the archives to use 
in explaining things. Showing how a real world problem was solved step 
by step has more impact than using myapp_t.

1 - *What SELinux isn't* - not an antivirus, will not fix 
vulnerabilities,  etc ....Maybe slip in a few lines explaining the 
concept of default permit and why this is a bad idea. *No such thing as 
a free lunch*. Which leads to the concept of default deny and....

2 - *What is SELinux and why should I care* - MAC system uses type 
enforcement to confine applications.....default deny. Everything that is 
to be allowed must be expressed in policy. Policy is complex because the 
system is complex. Typical usage of SELinux, the apache example would 
fit well in this section. What the goal of refpolicy is, where it is , 
where its going. Its not called reference policy for nothing, use as a 
building block.

3 - *Explain unconfined*. For instance going through the archives I 
found this little tidbit :


> Allowing unconfined_t to do things is ok; it is supposed to be unrestricted (and usually this happens automatically when you use the right type attributes on 
>any new types you define, like the "file_type" attribute for file types and the "domain" attribute for domains). 
>Allowing other domains to access unconfined_t is the concern. 

>http://www.nsa.gov/seLinux/list-archive/0610/17941.cfm

Above is the link to the message in the archives that I pulled the quote 
from, in case anyone is wondering about the context this was said in, 
though the statement by my estimation is straight forward and not 
context dependent in this case.

Some explanation of unconfined should be given and points like not 
letting other domains access unconfined should be made crystal clear, is 
it ever acceptable?If so under what conditions.

4 - *Admin Skills*

 From recent traffic to fedora-selinux :

> I guess this is the number one thing we need to teach unix
> administrators.  With SELinux when you get a permission denied message
> there are 3 things to check.  Ownership, Permissions which all admins
> have ingrained into them, and SELinux Label.
> 
> chown OWNER PATH
> chmod PERM PATH
> restorecon PATH

This brings us to the Z option , very useful, often forgotten(maybe it 
should be automatic with commands like ls -l). Also a complete listing 
of SELinux commands. Refer people to man pages except where command may 
be commonly used by admins.

Listing of most commonly encountered issues with explanations and 
typical fixes. The most important thing is explaining how to determine 
what the problem is and the general diagnostic approach one should use.

How do I tell the difference between the common and uncommon issues? Is 
there a general way to determine this? Somethings are never easy to 
explain but clues as to what should be looked for are invaluable.

Listing of not so common problems and a general diagnostic approach to 
take for these issues.

  At least a minimal list of info that you should include when asking 
for help on the mailing list. Who, what, when, where, why stuff that is 
useful in diagnosing problems. Like the top 5 things the SELinux guru 
would like to know or needs  to know to help resolve the issue.



5 - *audit2why and audit2allow* - The man pages explain pretty well what 
to do and how to do it. I would definitely include an explanation of 
these because they can be the primary tool for solving denials but if 
your going to copy and paste the man page then I would say don't bother. 
So I like the man page but if you can't take a slightly different 
approach to explaining it then I don't see the point of reiterating 
what's available from man audit2allow. Maybe just changing the order of 
the info presented would be enough, so its a little less tech manual and 
a little more conversational, more wiki less man page. This is the 
overall goal anyway.

 From the man page:

> 	Care must be exercised while acting on the output of  this  utility  to
>        ensure  that  the  operations  being  permitted  do not pose a security
>        threat. Often it is better to define new domains and/or types, or  make
>        other structural changes to narrowly allow an optimal set of operations
>        to succeed, as opposed to  blindly  implementing  the  sometimes  broad
>        changes  recommended  by this utility. 

This seems to me to be the most important point when using audit2allow. 
Here as a segue into writing policy there should be some of the *do nots 
of policy writing*, so if audit2allow happens to suggest one of these it 
either definitely shouldn't be allowed or requiring permissions of this 
kind should be considered an application bug or policy bug , bounce it 
off your distros selinux list etc...


>	  Certain permission denials are
>        not fatal to the application, in which case it  may  be  preferable  to
>        simply  suppress  logging  of  the denial via a ’dontaudit’ rule rather
>        than an ’allow’ rule.

Breakdown the different rules, at least one of each, explain the 
conventions of policy language. How deep into policy langauge this needs 
to go I am not sure but most of what prompts people to turn SELinux off 
or ignore it is lack of understanding. Nothing turns people off like 
being confused but being in the dark is worse, too much info is better 
than not enough IMO. For instance the reserved word self , the wildcard 
and complement operators, all useful to know about and very dangerous if 
you stumble across it and don't fully understand the implications of 
using or not using it.

6 - *Explanation of the major concepts*. Types, domains, context, object 
classes etc....

7 - *Thorough breakdown of AVC*. This is really important. It is 
essentially the face of SELinux. If all goes well you'll never know its 
there but if something breaks then this is likely to make me want to 
take a header off the nearest skyscraper :

time->Tue Jul 15 22:02:04 2008
type=SYSCALL msg=audit(1216173724.561:64): arch=c000003e syscall=6 
success=no exit=-13 a0=1bcdaa5 a1=7fff450fea80 a2=7fff450fea80 
a3=7faa3d0e4810 items=0 ppid=9135 pid=9143 auid=500 uid=500 gid=500 
euid=500 suid=500 fsuid=500 egid=500 sgid=500 fsgid=500 tty=pts2 ses=2 
comm="passwd" exe="/usr/bin/passwd" 
subj=unconfined_u:unconfined_r:passwd_t:s0-s0:c0.c1023 key=(null)
type=AVC msg=audit(1216173724.561:64): avc:  denied  { search } for 
pid=9143 comm="passwd" name="tmp" dev=dm-0 ino=12 
scontext=unconfined_u:unconfined_r:passwd_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:tmp_t:s0 tclass=dir

Now experienced admins can figure out most of it or google for answers 
but this is for the inexperienced, running a desktop system, exactly 
where this is needed most, they may not have basic admin skills or care 
about learning them, so a comprehensive breakdown of the AVC is 
essential. I should be able to bookmark this page and use it for reference.

8 - *ausearch* is another must have in the arsenal of the admin. Alot of 
options here. Just a small random selection of them :

  -c, --comm comm-name
               Search for an event based on the given comm name. The 
comm name is the executable’s name from the task structure.

        -hn, --host host-name
               Search for an event with the given host name. The 
hostname can be either a hostname, fully qualified domain name, or 
numeric network address.  No  attempt  is  made  to
               resolve numeric addresses to domain names or aliases.

        -if, --input file-name
               Use the given file instead if the logs. This is to aid 
analysis where the logs have been moved to another machine or only part 
of a log was saved.

        --input-logs
               Use the log file location from auditd.conf as input for 
searching. This is needed if you are using ausearch from a cron job.


*Lots of ways to search. Can be used in conjunction with audit2allow:*

[root@localhost ~]# ausearch -m avc | audit2allow


#============= NetworkManager_t ==============
allow NetworkManager_t fixed_disk_device_t:blk_file getattr;

#============= avahi_t ==============
allow avahi_t user_home_t:file write;

#============= consoletype_t ==============
allow consoletype_t dhcpc_state_t:file read;


9 - *Examples,Examples,Examples*

What did I search by?How can this be useful to me? Its all in the man 
pages of course but man pages are dry and the output is intimidating.

[root@localhost ~]# ausearch -a 30 | grep SYSCALL
type=SYSCALL msg=audit(1212681693.050:30): arch=c000003e syscall=59 
success=yes exit=0 a0=403665 a1=7fff4a0fbba0 a2=7fff4a0fc228 a3=0 
items=0 ppid=5712 pid=5713 auid=4294967295 uid=0 gid=0 euid=0 suid=0 
fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="umount" 
exe="/bin/umount" subj=system_u:system_r:mount_t:s0 key=(null)
type=SYSCALL msg=audit(1213111393.121:30): arch=c000003e syscall=2 
success=no exit=-13 a0=7fff0a76d7d0 a1=2 a2=14 a3=0 items=0 ppid=4308 
pid=4309 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 
fsgid=0 tty=(none) ses=4294967295 comm="lsusb" exe="/sbin/lsusb" 
subj=system_u:system_r:cupsd_config_t:s0 key=(null)
type=SYSCALL msg=audit(1214321269.400:30): arch=c000003e syscall=59 
success=yes exit=0 a0=14ebba0 a1=14a53c0 a2=14a8b20 a3=8 items=0 
ppid=4104 pid=4114 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 
sgid=0 fsgid=0 tty=pts1 ses=1 comm="iptables" exe="/sbin/iptables" 
subj=unconfined_u:system_r:iptables_t:s0 key=(null)


Leave no stone unturned. Make them laugh, make them cry, make an 
impression. Sometimes when explaining technical concepts to the 
uninitiated you must sacrifice being strictly accurate in favor of 
getting the larger point across. Once the larger point is made then each 
person can begin to work out the details but having the details without 
an appreciation of the larger picture causes more problems than it solves.


Max



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
