Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: russell@coker.com.au, Joshua Brindle <jbrindle@tresys.com>,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200508041435.j74EZ4jY011001@turing-police.cc.vt.edu>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <42EE3879.2050409@tresys.com>
	 <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
	 <200508041757.54938.russell@coker.com.au>
	 <200508041435.j74EZ4jY011001@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 10:38:09 -0400
Message-Id: <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 10:35 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 04 Aug 2005 17:57:50 +1000, Russell Coker said:
> 
> > One thing that was idly discussed was a public build server that would use one 
> > domain and several types for every package that was to be compiled.  When you 
> > look at distributions such as Debian with ~10,000 packages the number 64K 
> > doesn't seem so large.
> 
> 10K?? I only count 1,806 in Fedora Core 4....
> 
> What percent of these packages need any special handling other than
> "run as the invoking user"? FC4 has about 180 .te files in domains/programs,
> so just about 10% there.  I have *no* idea if "the next 8K packages" will
> sustain that 10%, or if it will be significantly lower.
> 
> In any case, yes, that could run over 64K.

But if you have >64K types, then your avtab is likely going to be so
large as to make the policy unuseable anyway, as noted by Joshua
earlier.

With regard to categories, since the relationships are implicit and
governed by the constraints, you don't get the kind of policy growth
from adding more categories that you would from adding more types.  So
if your goal is simply strict isolation between the different packages
during their builds (not the same as isolating the resulting programs
running on an end system), then categories may indeed be more suitable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
