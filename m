Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03647
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 09:48:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA25203
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:47:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA25199
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:47:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Samarth Sharma" <samarth7880@rediffmail.com>, selinux@tycho.nsa.gov
Subject: Re:
Date: Thu, 8 Aug 2002 15:48:10 +0200
References: <20020808112849.16449.qmail@webmail26.rediffmail.com>
In-Reply-To: <20020808112849.16449.qmail@webmail26.rediffmail.com>
MIME-Version: 1.0
Message-Id: <20020808134810.D71F23CA7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Aug 2002 13:28, Samarth  Sharma wrote:
>   A security aware application like the sshd daemon acts as an
> object manager for all its related processes..is this correct?? or
> are object managers are a part of the kernel.

The kernel fully manages all accesses granted to all domains.

sshd can determine the initial Identity, Role, and Domain (which together 
comprise the context) for the process, but it's choices in this regard are 
limited by the SE policy.

In a default configuration sshd can only run processes in sshd_t or user_t 
domains and in the user_r or system_r roles.  If it runs a process in the 
sshd_t domain and the system_r role then that process can do very few things 
(basically run other copies of sshd).

The worst that sshd can do in the default configuration is to run a process 
as UID=0 in the user_t domain.

>   if sshd does act as an object manager who enforces the access
> decisions for the sshd daemon..

The only decisions that sshd can make are what domain to run the child 
process in, and they are very limited.

If you want a really locked down system then you have no files stored in type 
user_home_t and force the user to run "newrole" before executing any 
processes.  That would have saved you from most past exploits of sshd and 
hopefully from future exploits.  But it still wouldn't save you from a 
trojaned sshd that monitors your keypresses when you enter the password for 
newrole.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
