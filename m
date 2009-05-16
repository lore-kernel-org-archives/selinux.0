Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4GGPRna029795
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 12:25:28 -0400
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4GGPWrm016673
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 16:25:32 GMT
Received: by ey-out-1920.google.com with SMTP id 3so641243eyh.30
        for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 09:25:25 -0700 (PDT)
Subject: Re: write selinux policy
From: Dominick Grift <domg472@gmail.com>
To: hechao55429 <hechao55429@126.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <17697801.901261242485650930.JavaMail.coremail@bj126app52.126.com>
References: 
	 <17697801.901261242485650930.JavaMail.coremail@bj126app52.126.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 May 2009 18:25:22 +0200
Message-Id: <1242491122.22621.17.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-05-16 at 22:54 +0800, hechao55429 wrote:
> hello everyone:
>    I'm now studying selinux policy on fedora 10  .  I wrote a policy
> module like this:
>         myapp.if
> ## <summary>this si to constraint gedit</summary>
>         myapp.te
> policy_module(myapp,1.0.0) 
> type myapp_t;
> # Access to shared libraries
> libs_use_ld_so(myapp_t)
> libs_use_shared_libs(myapp_t)
> miscfiles_read_localization(myapp_t)
> type myapp_exec_t;
> type myapp_rw_t;
> files_type(myapp_exec_t)
> files_type(myapp_rw_t)
> init_domain(myapp_t,myapp_exec_t)  
> allow myapp_t myapp_rw_t :file ~{write};
>   myapp.fc
> /usr/bin/gedit -- gen_context(system_u:object_r:myapp_exec_t,s0)  
> /root/share/a/as -- gen_context(system_u:object_r:myapp_rw_t,s0)
> Then i compiled it and it created myapp.pp with no error.
> And then i used the command that semodule -i myapp.pp and it succeeded
>  Then i relabeled the files by using the restorecon command and
> reboot .
> But after it reboot ,the  /usr/bin/gedit  still  ran on the
> unconfined_t domain. 
> why?
One reason is because you do not have a proper transition rule.

Below you see an example that confines Gedit for an unconfined user.
This example only gets you started and it in this example Gedit is an
permissive domain. The example only has a few declaration and minimum
policy to achieve the goal of confining it for unconfined users.

~/mygedit/mygedit.te file:

policy_module(mygedit, 0.0.1)
type gedit_t;
type gedit_exec_t;
application_executable_file(gedit_exec_t)
application_domain(gedit_t, gedit_exec_t)
role unconfined_r types gedit_t;
permissive gedit_t;
require { type unconfined_t; }
domain_auto_trans(unconfined_t, gedit_exec_t, gedit_t)

~/mygedit/mygedit.fc file:

/usr/bin/gedit -- gen_context(system_u:object_r:gedit_exec_t, s0)

compile & install:

cd ~/mygedit; make -f /usr/share/selinux/devel/Makefile;
sudo semodule -i mygedit.pp;
sudo restorecon -v /usr/bin/gedit

If all was well then, when you (an unconfined user) executes gedit, the
process should transition to gedit_t.
You can verify this with ps -auxZ | grep gedit
Now you can accumulate avc_denials and extend you policy to your liking.
Once you are done with testing and extending, you should comment the
line that says: permissive gedit_t; or remove it from policy. Then
rebuild the module and reinstall.

By the way, we also have a few friendly IRC channels on irc.freenode.org
(#selinux and #fedora-selinux) where you can get some more personal
assistence and where you can have friendly SELinux related chats!

Good luck

> 
> 
> 
> 
> ______________________________________________________________________
> 穿越地震带 纪念汶川地震一周年


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
