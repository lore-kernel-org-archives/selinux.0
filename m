From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: writing zero bytes in bash
Date: Tue, 1 Mar 2005 07:21:59 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200502261832.16337.russell@coker.com.au> <1109616468.28470.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1109616468.28470.20.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503010721.59865.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 01 March 2005 05:47, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > If you want to do this in a shell script you would do something like:
> > echo -n "" > /proc/self/attr/fscreate
>
> Using the /proc/self/attr API from a shell script makes little sense, as
> any programs run by the script are going to have their attributes reset
> upon execve anyway.  It would only affect shell builtins, and likely
> just cause confusion.

/proc/self/attr/exec will give the same result as 
runcon.  /proc/self/attr/fscreate works for operations such as
"program > file".

We need to have a way to test these things.  If we can't make it possible to 
do these things through the shell then someone (maybe me) has to write an 
interactive program to exercise the SE Linux API.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
