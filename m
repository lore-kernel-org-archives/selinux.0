From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 09:17:01 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <407BF24E.90901@redhat.com>
In-Reply-To: <407BF24E.90901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404140917.01773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Apr 2004 23:59, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Ideas?

For most items in tunable.te they won't be changed often or for small reasons.  
In some cases changing tunable.te will require application restart (or system 
reboot) to fully take affect.

The aim of booleans is for things that are designed to be transient (EG secure 
levels).

Also if we use booleans for tunables we need to have boolean support for role 
and domain transitions (currently not implemented), and a mechanism for 
preserving boolean values across a reboot.

I think it's best to continue with tunables the way they are.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
