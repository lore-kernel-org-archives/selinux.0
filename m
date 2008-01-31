MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Accurately setting Security Context of a  user when ssh-ing in
Date: Wed, 30 Jan 2008 19:35:11 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0451FF16@de01exm68.ds.mot.com>
in-reply-to: <47A08F44.20308@redhat.com>
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

What file or info in the policy determines what security context a user
will get after ssh-ing in...?

In other words, If I have a Linux_user = Admin, which is mapped to
SELinux_user = staff_u , SELinux_role = staff_r, how do I guarantee that
when I ssh in as "Admin", I will ALWAYS get the security_context =
staff_u:staff_r:staff_t 


The reason I ask is as follows:

I have developed a certain collection of *strict* policies on a Fedora
machine that achieve what I want. 
When I ssh into this Fedora machine as "Admin", I do get the context =
staff_u:staff_r:staff_t

So I tar up everything in the  /etc/selinux/  directory, and create a
selinux_policies.tar  lets say.

Now, I untar selinux_policies.tar onto *another* machine (Machine B)!

Then when I ssh into Machine B, with Linux account "Admin", I get
security_context = sysadm_u:sysadm_r:sysadm_t  ?!?

Weird thing is, If I reset Machine B, and *then*  ssh in as "Admin", I
then get the correct security_context = staff_u:staff_r:staff_t.

So after untarring the collection of policies (the entire
/etc/selinux/***  directory):
   1. when I ssh in as Admin, I always get the wrong security_context
   2. But if I reset the machine, and after machine comes up, if I then
ssh in as Admin, I get the correct security_context.
   3. subsequent resets, and ssh-ing in still gives me the correct
security_context...

A. So why am I getting the wrong security_context after untarring
/etc/selinux/***  onto a target machine B.
B. And why is resetting the machine fixing this problem ?

Hopefully the question was not too confusing  ;-)

Thanks in advance for any help.
    


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
