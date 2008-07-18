Subject: Re: [refpolicy] Patch: Create non_security_file_type attribute
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1216397010.26625.53.camel@moss-lions.epoch.ncsc.mil>
References: <1214592935.2888.11.camel@moss-lions.epoch.ncsc.mil>
	 <1216390554.21191.147.camel@gorn>
	 <1216395738.26625.45.camel@moss-lions.epoch.ncsc.mil>
	 <1216396152.21191.163.camel@gorn>
	 <1216397010.26625.53.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 14:09:10 -0400
Message-Id: <1216404550.21191.170.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-18 at 12:03 -0400, James Carter wrote:
> On Fri, 2008-07-18 at 11:49 -0400, Christopher J. PeBenito wrote:
> > On Fri, 2008-07-18 at 11:42 -0400, James Carter wrote:
> > > On Fri, 2008-07-18 at 10:15 -0400, Christopher J. PeBenito wrote:
> > > > On Fri, 2008-06-27 at 14:55 -0400, James Carter wrote:
> > > > > This patch eliminates the expansion of the file_type attribute (due to
> > > > > the "-" set operation) for the *_non_security interfaces by creating a
> > > > > non_security_file_type attribute.
> > > > > 
> > > > > On my system the resulting binary policy is almost 20% smaller.  The
> > > > > difference is so large because there are over 1000 types labeled with
> > > > > the file_type attribute.
> > > > 
> > > > I'm hesitant to attach non_security_file_type to the files_type
> > > > attribute, since its not clear to me that it makes conceptual sense.
> > > 
> > > The primary goal here is a smaller binary policy.  But it still makes
> > > sense conceptually to me because the security_file_type attribute is
> > > never used by itself as far as I can tell.  It is always used as
> > > {file_type-security_file_type}.
> > > 
> > > >   In
> > > > fact a sediff of the policy reveals that auidtd_log_t gains
> > > > non_security_file_type while it already has security_file_type, which
> > > > results in rule additions with this patch added.
> > > That's not good.  There are only a handful of types labeled with
> > > security_file_type, I don't know how I missed that.  Sorry.
> > > 
> > > The following line is the problem: files_mountpoint(auditd_log_t).
> > > So, a files_mountpoint_security interface would have to be created.
> > > 
> > > It's not a big deal to me.  If there is no interest in creating a
> > > non_security_file_type attribute, I won't pursue this any farther.
> > 
> > I think the binary policy size savings is a good enough reason to pursue
> > it.  Brainstorming for a second, another way to address this problem
> > would be to change how checkpolicy handles negations.  It could make a
> > new attribute with the resultant type set from the negation;
> 
> It would need to make sure that the resultant set is not already covered
> by an attribute, or much of the value would be lost.

Yes, that would make sense.

> >  however,
> > that might be bad for analysis since an attribute would magically appear
> > out of nowhere.
> 
> You already have that problem when analyzing a binary policy, since the
> attribute names aren't preserved.

Well what I mean is that you have your source policy which has X
attributes, but when you open up your binary policy in setools you have
X+1, so you wonder if something bad is happening in the compiler, since
the source and binary don't match up.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
