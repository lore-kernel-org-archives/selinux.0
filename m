From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nick <nick-lists@austin.rr.com>
Subject: Re: SELinux Policy Editor and CAP_SYS_BOOT
Date: Sat, 23 Apr 2005 08:47:29 +1000
Cc: SELinux@tycho.nsa.gov
References: <1105645034.32758.35.camel@hawaii.efficax.net>
In-Reply-To: <1105645034.32758.35.camel@hawaii.efficax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504230847.32685.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 January 2005 06:37, Nick <nick-lists@austin.rr.com> wrote:
> I have the need to enable (and make work) the shutdown and halt
> accounts. I set a password for these accounts and tried to use them and
> got the expected "you must be root" a collegue pointed out that I might
> need the CAP_SYS_BOOT capability turned on. After an hour of Googling on
> something that relates to CAP_SYS_BOOT and makes sense within the
> context of SELinux.

init_t has capability sys_boot as it is the domain that instructs the kernel 
to reboot in normal situations.  The administrator merely asks the init 
process to perform the reboot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
