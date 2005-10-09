Date: Sun, 9 Oct 2005 15:50:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: More Debian bugs
Message-ID: <20051009145000.GU18797@lkcl.net>
References: <20050923195227.GA21546@vnl.com> <200510092019.41106.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510092019.41106.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 09, 2005 at 08:19:31PM +1000, Russell Coker wrote:
> On Saturday 24 September 2005 05:52, Dale Amon <amon@vnl.com> wrote:
> > As I plough onwards... with last nights set of hacks
> > I was able to label files today. But that is about it.
> > The latest debian packaged kernel turns out to have
> > POLICYVERS=19 in security.h. However, the selinux-policy-default
> > package builds a policy.20.
> 
> I've just uploaded a new policy package to Debian that fixes this issue and 
> many other problems.  With this and Manoj's recent package uploads things are 
> starting to get back into shape for Debian SE Linux.
> 
> One thing to note is that udev now seems a standard part of sid.  Udev on it's 
> own seems a bit broken in Debian (for example not mounting /dev/pts), and in 
> conjunction with SE Linux there's even more fun.  I don't expect udev and SE 
> Linux to work well together on Debian for some weeks or maybe months.
 
 ah.

 there are two ways this needs to be fixed.

 1) initrd removed from debian

 2) udev moved into initrd like you have with redhat.

 gotta run.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
