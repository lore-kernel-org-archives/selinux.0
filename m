From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re:
Date: Sat, 3 Sep 2005 22:10:19 +1000
Cc: "SELinux List" <SELinux@tycho.nsa.gov>
References: <200509021632.j82GWrss022126@gotham.columbia.tresys.com>
In-Reply-To: <200509021632.j82GWrss022126@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509032210.21836.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 03 September 2005 02:32, "Karl MacMillan" <kmacmillan@tresys.com> 
wrote:
> Under what conditions is quotaon checked for files?

When you enable quotas for a file system and instruct the kernel that the file 
in question is to be used for storing the quota database.

> After some looking I 
> found that you can mount a file on another file using bind mount - which I
> was not previously aware of - which would trigger the mounton check. It is
> not clear to me, though, when quotaon would be checked and whether it is
> related to the bind mount of a file on another file.

I can not imagine any sane reason for someone bind-mounting a quota file from 
another file system.  I'm not even certain that it would work in any 
situation - there may be kernel code that makes assumptions about the file 
being on the same file system.  The only possible reasons I can think of 
involve malicious use by a root kit.

So I think we have no need to support such things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
