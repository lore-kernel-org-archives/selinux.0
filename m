Date: Wed, 14 Apr 2004 16:19:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
In-Reply-To: <Xine.LNX.4.44.0404141553580.21808-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0404141616500.21808-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Apr 2004, James Morris wrote:

> I think it's worse than this.  It looks like we're using about 40 bytes of
> kernel memory for each rule, and with almost 300,000 rules, it's more like
> 12MB (for i386).

Actually it's 32 bytes per rule (I had slab debugging enabled, which uses
a bit more), but still a lot.  And on 64-bit, it's using twice as much
memory.

- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
