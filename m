From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Thu, 15 Apr 2004 02:00:31 +1000
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
References: <200404141410.i3EEA0Jx015621@gotham.columbia.tresys.com>
In-Reply-To: <200404141410.i3EEA0Jx015621@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404150200.31607.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Apr 2004 00:10, "Karl MacMillan" <kmacmillan@tresys.com> wrote:
> Sure - init should have the privileges to do this. The only detail is that
> this should be done before any daemons are started - is rc.sysinit run
> early enough?

rc.sysinit is run directly from init before it does anything else.  Maybe we 
could fsck the root fs before changing booleans, but that should be OK.

If you have booleans affecting the core operations of init and scripts it 
launches then you are just asking for trouble.

The only thing which affects init_t or initrc_t in any significant way which 
could be a boolean (IMHO) is the ability of those domains to change booleans.  
If we have initrc_t changing booleans on startup then one option is having it 
remove it's own access to change the booleans after it's done so.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
