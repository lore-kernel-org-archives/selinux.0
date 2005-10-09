From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: More Debian bugs
Date: Sun, 9 Oct 2005 20:19:31 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
References: <20050923195227.GA21546@vnl.com>
In-Reply-To: <20050923195227.GA21546@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510092019.41106.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 24 September 2005 05:52, Dale Amon <amon@vnl.com> wrote:
> As I plough onwards... with last nights set of hacks
> I was able to label files today. But that is about it.
> The latest debian packaged kernel turns out to have
> POLICYVERS=19 in security.h. However, the selinux-policy-default
> package builds a policy.20.

I've just uploaded a new policy package to Debian that fixes this issue and 
many other problems.  With this and Manoj's recent package uploads things are 
starting to get back into shape for Debian SE Linux.

One thing to note is that udev now seems a standard part of sid.  Udev on it's 
own seems a bit broken in Debian (for example not mounting /dev/pts), and in 
conjunction with SE Linux there's even more fun.  I don't expect udev and SE 
Linux to work well together on Debian for some weeks or maybe months.

Also my policy package for Debian still asks heaps of questions.  I won't fix 
that until we get the reference policy going.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
