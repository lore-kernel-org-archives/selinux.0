From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Verify the integrity of downloaded archives
Date: Sun, 9 Nov 2003 09:16:51 +1100
Cc: SELinux@tycho.nsa.gov
References: <000001c3a3db$2dad18f0$02000a0a@lady> <200311060111.16197.wlsel@verizon.net> <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311090916.51612.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 Nov 2003 01:24, Stephen Smalley wrote:
> On Thu, 2003-11-06 at 01:11, Bill Laut wrote:
> > While I'd love to meet a hacker who could successfully break into the
> > NSA's website to install a Trojan (;-), Oliver does bring up a good
> > point.  As SELinux gains a wider audience it would be reasonable to
> > anticipate the distro eventually getting mirrored at other sites.  Since
> > the use of digital signatures as an integrity-check is now commonplace
> > within the Linux community, would it be reasonable to start posting
> > signatures on the NSA website?
>
> Possibly.  Since we originally released SELinux as a proof of concept /
> reference implementation and it has never been intended to be a Linux
> distribution unto itself (although it can be incorporated into one),
> this hasn't been a major concern in the past.  However, I understand the
> concern.  On the other hand, on what basis would you trust the key used
> to sign the archives and patches?

I think that the correct proceedure is for a GPG key to be established for the 
sole purpose of signing SE Linux releases.  Then that key would be signed by 
keys from you, Howard, and Pete Loscocco (the three NSA people who seem to 
meet the most people who are in the web of trust).

Then once you get your keys signed by a few people I think that everyone will 
be satisfied by the key integrity.

This is essentially the same proceedure that is used for the kernel source 
signatures on kernel.org.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
