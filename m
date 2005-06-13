Date: Mon, 13 Jun 2005 23:44:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050613224454.GF17617@lkcl.net>
References: <20050613213951.GB17617@lkcl.net> <20050613220328.31770.qmail@web31602.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050613220328.31770.qmail@web31602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 13, 2005 at 03:03:28PM -0700, Casey Schaufler wrote:
> 
> 
> --- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
> wrote:
> 
> 
> >  wilma@DOI1 has **nothing** to do with wilma@DOI2.
> 
> This is the sort of thing that seperates the
> developers from the admins. Of course wilma@DOI1
> isn't wilma@DOI2. Nonetheless, reams of
> documentation and countless warnings
> notwithstanding, the human that creates the mapping
> between DOI1 and DOI2 will 99 44/100% of the time
> map wilma directly to wilma. It's bad enough for
> usernames. I see no reason to expect it to be
> any better for policy constructs.

 everyone sees "Administrator" on local workstations.

 do they _genuinely_ believe that "Administrator" on workstation
 1 is the same as "Administrator" on workstation 2??

 ... but anyway: the lessons there should be learned from the
 way that nt's "active directory" infrastructure is managed.

 if it's dumb enough for nt admins to not screw up...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
