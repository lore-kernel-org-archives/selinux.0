Subject: Re: writing zero bytes in bash
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au,
   Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200502261832.16337.russell@coker.com.au>
References: <200502261832.16337.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 13:47:48 -0500
Message-Id: <1109616468.28470.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-02-26 at 18:32 +1100, Russell Coker wrote:
> This message is intentionally sent to the fedora-devel-list and the SE Linux 
> list not the fedora-selinux-list.  It is not related to Fedora specific SE 
> Linux functionality, but it is related to bash (a core part of Fedora) and SE 
> Linux kernel code.
> 
> To unset the fscreate or exec context you have to write zero bytes 
> to /proc/self/attr/fscreate or /proc/self/attr/exec respectively.
> 
> If you want to do this in a shell script you would do something like:
> echo -n "" > /proc/self/attr/fscreate

Using the /proc/self/attr API from a shell script makes little sense, as
any programs run by the script are going to have their attributes reset
upon execve anyway.  It would only affect shell builtins, and likely
just cause confusion.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
