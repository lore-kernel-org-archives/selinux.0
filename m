From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>,
   Douglas Phillipson <phillipd@oem.doe.gov>
Subject: Re: Opinions on installing SeLinux on different distros
Date: Fri, 21 Mar 2003 11:57:00 +0100
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <3E7A0B04.4090502@oem.doe.gov> <1048195831.24500.119.camel@moss-sooners.epoch.ncsc.mil>
In-Reply-To: <1048195831.24500.119.camel@moss-sooners.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303211157.00904.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Mar 2003 22:30, Howard Holm wrote:
> Russell Coker has done much excellent work in bringing SELinux to
> Debian, and provides the appropriate set of patched applications (which
> are very close to the Red Hat applications) and a Debian specific
> example policy.  Again, you'll probably need to modify the policy to
> meet your specific needs.

Thanks for the nice reference.

My work on SE Debian is aimed at making it an integral part of the OS.  So 
basic functionality of the OS such as package upgrades on a running server 
will still work.  I believe that if you prevent usual operation of the system 
then you reduce security by limiting the number of machines that can run SE 
Linux, and by preventing the administrator from performing important tasks 
such as prompt application of patches.

The aim is that you should be able to install Debian with SE Linux and for the 
base functionality and commonly used programs it should all just work with 
minimal changes.

When changes to policy are required I am very interested in merging any policy 
contributed by users.

> See the README in the SELinux distribution on the NSA web site
> http://www.nsa.gov/selinux/ for Red Hat instructions.  I'm sure Russell
> could provide Debian instructions.

My web site http://www.coker.com.au/selinux/ provides some basic info, but 
I've been too busy coding to do much.

Faye's document is mostly focussed on Debian.  Go to 
http://sourceforge.net/projects/selinux , go to the "Docs" section and Faye's 
document is the first entry.

> > 8) I understand that  the "Secure Computing" corporation had a hand in
> > this.  Do they have a commercial version available or one planned?
>
> I'm not aware of any currently available commercial version of SELinux.

Some commercial distributions have been looking into the issue.  However since 
the dot-com crash no-one has wanted to do any speculative development.  If a 
big customer was to approach a commercial distribution with a demand for SE 
Linux support then maybe something could be arranged.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
