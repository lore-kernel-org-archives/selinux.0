Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HFuQWt010125
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:56:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9HFuH0p019376
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:56:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9HFuHr7019373
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:56:17 GMT
Subject: Re: Sample config
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Inger, Slav (S.B.)" <vinger@ford.com>
Cc: "SELinux ML (E-mail)" <selinux@tycho.nsa.gov>
In-Reply-To: <752E6D5014672D458A593B5E7A3CD5F56165CD@na1fcm51.dearborn.ford.com>
References: 
	 <752E6D5014672D458A593B5E7A3CD5F56165CD@na1fcm51.dearborn.ford.com>
Content-Type: text/plain
Message-Id: <1066406183.31764.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Oct 2003 11:56:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-17 at 11:38, Inger, Slav (S.B.) wrote:
> Hi,
> 
> In my environment, 'root' has a role of sysadm_r.  Running SELinux in 
> permissive mode and looking at the avc messages, all violations apply 
> to the kernel_t context.  Also, all of the processes on the system seem 
> to be running in kernel_t context as well.  I can use newrules.pl to relax
>  the rules (basically add a bunch of 'allow kernel_t' lines, but that's not
>  the point.  What I would like to demonstrate is that user 'root' can do 
> all of his normal sysadmin chores EXCEPT kill some process or rm some file.
>   Let's say he shouldn't be able to kill sshd and overwrite or remove 
> /var/log/messages (but appending is fine).  This is pretty easy to do 
> with LIDS, I need to know how administratively intensive it is to set 
> up these rules in SELinux.  What specific rules do I need to 
> add/remove/change to make what I'm asking for happen?  Thanks in advance.

First, you need to get your system into a working state, which it isn't
if everything is running in kernel_t.  Did you label your filesystem? 
Does ls --context /sbin/init show the correct context?  If not, then
relabel your filesystem and reboot as per the README.  If it is labeled
correctly, then another possible explanation is that you didn't load the
policy via an initrd prior to executing /sbin/init, so the domain
transition didn't occur.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
