From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
Date: Fri, 5 Aug 2005 01:46:31 +1000
Cc: Valdis.Kletnieks@vt.edu, Joshua Brindle <jbrindle@tresys.com>,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil> <200508041435.j74EZ4jY011001@turing-police.cc.vt.edu> <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508050146.37993.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 August 2005 00:38, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2005-08-04 at 10:35 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 04 Aug 2005 17:57:50 +1000, Russell Coker said:
> > > One thing that was idly discussed was a public build server that would
> > > use one domain and several types for every package that was to be
> > > compiled.  When you look at distributions such as Debian with ~10,000
> > > packages the number 64K doesn't seem so large.
> >
> > 10K?? I only count 1,806 in Fedora Core 4....

In terms of 10K packages I was referring to Debian.  If Fedora Extras meets my 
personal criteria for success then it will bring the size of Fedora to the 
same approximate size as Debian.  Also we want to support all the operations 
on all distributions.

> > What percent of these packages need any special handling other than
> > "run as the invoking user"? FC4 has about 180 .te files in
> > domains/programs, so just about 10% there.  I have *no* idea if "the next
> > 8K packages" will sustain that 10%, or if it will be significantly lower.

The idea is that when the build system compiles a package the compilation 
scripts should not be able to interfere with other compilations (apart from 
running out of memory or other system resources).  One issue is that of 
hostile build scripts, having a hostile package do bad things when the 
package in question is installed has a lot of potential for damage.  Allowing 
the build scripts to trash the build system or corrupt other packages such 
that it can't easily be determined which package started the damage would be 
a worse situation.

> > In any case, yes, that could run over 64K.
>
> But if you have >64K types, then your avtab is likely going to be so
> large as to make the policy unuseable anyway, as noted by Joshua
> earlier.

OK.

> With regard to categories, since the relationships are implicit and
> governed by the constraints, you don't get the kind of policy growth
> from adding more categories that you would from adding more types.  So
> if your goal is simply strict isolation between the different packages
> during their builds (not the same as isolating the resulting programs
> running on an end system), then categories may indeed be more suitable.

So there is no inherent problem with 10,000 categories?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
