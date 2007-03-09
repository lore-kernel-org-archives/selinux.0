Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29ENO5x021486
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 09:23:24 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29ENMto004366
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 14:23:23 GMT
Received: by nf-out-0910.google.com with SMTP id n15so1069185nfc
        for <selinux@tycho.nsa.gov>; Fri, 09 Mar 2007 06:23:22 -0800 (PST)
Message-ID: <9d1b82480703090623y3fb9cfa2qf6e3dcc7e8af501@mail.gmail.com>
Date: Fri, 9 Mar 2007 19:53:22 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: CKRM and SELinux
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1173373223.10467.112.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
	 <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
	 <1172581266.19041.312.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480702271307q45bfc167mff78dc03a6c9b482@mail.gmail.com>
	 <1172611097.19041.428.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480703080853v137069a7h338108de5dc1e480@mail.gmail.com>
	 <1173373223.10467.112.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> To do that, you need
> security hooks in the underlying code at the appropriate points where
> you have enough semantic information to make a security check.  As a
> simple example, consider the cpuset pseudo filesystem.  Processes may
> write a pid in string form to one of the files in order to act on the
> process with that pid.  Simply controlling writes to the file doesn't
> enable us to control what processes you can affect; we needed a security
> hook in that code after looking up the pid to check whether you could
> affect that particular process (based on its context).

To add all those security hooks, I think, we need to do following changes.

Add security_context to res_group structure in (include/linux/res_group.h)

We also need to add following hooks to CKRM code.
All these hooks are mint to control some specific action.
I can think of following actions to be controlled using SELinux.
------------------------------------------------------------------
1. Can process A  "create new res_group" in existing res_group C ?
    ---> Hook for creating class can go in function "make_rgcs_rgroup"
(in kernel/res_group/rgcs.c).
          This function have information regarding which task is
creating res_group and
          in which res_group is it getting created.
------------------------------------------------------------------
2. Can process A "delete" res_group C ?
    ---> Hook can go in function "rgcs_rgroup_release_item" (in
kernel/res_group/rgcs.c).
         This function have information regarding who is deleting
which res_group.
------------------------------------------------------------------

3. Can process A "modify the share" of res_group C ?
   ---> Hook for changing the share can be added in function
"set_shares" (in kernel/res_group/rgcs.c).

------------------------------------------------------------------
4. Can process A "see the status" of res_group C ?
   --> Hook can go in "show_stats" in (in kernel/res_group/rgcs.c).

------------------------------------------------------------------

Actions like "Can process A "add" process B in res_group C" will be
having some difficulty as it is involving 3 ojects and one action (ie
"add"). And SELinux ACL's normally work on two objects at one time, So
I am planning to break it into sub-actions as follows.

5. Can process A add process B in res_group C ?
         1. Can process A write in res_group C ?
         2. Can process B be member of res_group C ?
         3. Can process A controls grouping of process B ?
             ---> All these three hooks can go in "set_res_group" in
(in kernel/res_group/task.c).
                   as access to res_group C and task_struct for A and B.
------------------------------------------------------------------

On similar line, one has to do for Removing the process from perticular class.

6. Can process A delete process B from res_group C ?
         1. Can process A write in res_group C ?
         2. Can process A controls grouping of process B ?
           ---> Unfortunately, I am facing some trubbles in adding
hooks for deletion.
                 I am not yet able to locate the code which removes
the processes from a class.
------------------------------------------------------------------

I have not tried to control "resource-controllers" from SELinux ACL's.
Those ACL's will be on following lines
 Can process A "modity" share of res-group B only for resource type "CPU".
I dont know if even that is required. I feel that will be overkill.
With the rules that I have planned, If process A can modify shares of
res-group B, then it can modify all of its shares.

---------------------------------------------------------------

I hope that I am going on correct line.
I dont know if these hooks are enough or correct.
Please let me know if I need to consider something else also.

Thanx,
-- 
Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
