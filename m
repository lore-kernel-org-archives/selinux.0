Date: Wed, 14 Apr 2004 15:58:52 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
In-Reply-To: <200404150219.27857.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0404141553580.21808-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Apr 2004, Russell Coker wrote:

> I think that the issue with performance is kernel memory use.  Currently for 
> FC2T2 we have 7M policydb files which roughly equates to 7M of kernel memory 
> reserved, which has a huge impact on older hardware!  Most of this is due to 
> compiling in support for every .te file.

I think it's worse than this.  It looks like we're using about 40 bytes of
kernel memory for each rule, and with almost 300,000 rules, it's more like
12MB (for i386).

Making better use of kernel memory is on my todo list.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
