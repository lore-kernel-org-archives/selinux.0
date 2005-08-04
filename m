From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
Date: Thu, 4 Aug 2005 17:57:50 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, James Morris <jmorris@redhat.com>,
   selinux@tycho.nsa.gov
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil> <42EE3879.2050409@tresys.com> <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508041757.54938.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 August 2005 01:09, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Also, my real question here is whether we are sure that 16 bit value
> space is going to be enough forever for types.

I don't think so.

One thing that was idly discussed was a public build server that would use one 
domain and several types for every package that was to be compiled.  When you 
look at distributions such as Debian with ~10,000 packages the number 64K 
doesn't seem so large.

But maybe the MCS policy will reduce the need for types.  How well would a 
system with 10,000 categories work?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
