Subject: Re: Where is the SID stored in file system and process
	respectively?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041223055909.94522.qmail@web51507.mail.yahoo.com>
References: <20041223055909.94522.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1104154766.15615.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Dec 2004 08:39:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-23 at 00:59, Park Lee wrote:
>   As we know, In SELinux, when we first access a file,
> the file system should first send the security context
> of the file from its extended attribute to security
> server. the security server will give a SID back to
> the file for later use. Since then, every time when we
> access the file, there is no need for the file system
> to send the security context of the file again.
> instead, it will send the SID of the file to security
> server. 

This kind of question seems most appropriate to the
selinux@tycho.nsa.gov list, not the fedora-selinux-list or the
linux-security-module list.  In any event, please just post the question
to one list (not all of them) and wait patiently for an answer.

>   But, Where is the SID (which is assigned by security
> server for the file) stored in the file system? and
> How is the SID calculated?
>  
>   
>   As for process in selinux, Where is the SID (which
> also is assigned by security server ) stored with the
> process? 
>   Is the security context of the process only exist in
> the selinux security server and the process only need
> to deal with the SID that is related to the security
> context? 
>   Will the process itself handle its own security
> context?

The SID is stored in the in-core security data structure associated with
the kernel's data structure for the object (whether an inode or a
process).  It is not stored persistently.  SIDs are just dynamically
allocated on demand as integers; they are non-persistent and local, as
explained in the Flask paper.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
