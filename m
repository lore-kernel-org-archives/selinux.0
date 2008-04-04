Subject: Re: Audit2allow + allow rule for 'granted' access
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Karrels, Jeffrey J (US SSA)" <jeffrey.karrels@baesystems.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4AE25A7D8CBE4E4DA8E87173237DE27E8B95@blums0042.bluelnk.net>
References: <4AE25A7D8CBE4E4DA8E87173237DE27E8B95@blums0042.bluelnk.net>
Content-Type: text/plain; charset=utf-8
Date: Fri, 04 Apr 2008 08:04:51 -0400
Message-Id: <1207310691.27710.315.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-03 at 16:06 -0700, Karrels, Jeffrey J (US SSA) wrote:
> Not that this is a big deal, but is there a way to stop audit2allow
> from processing and creating rules for audits that are ‘granted’? 
> 
>  
> 
> I turned on auditing for a couple of rules so I can keep an eye on
> domain transitions. That creates some entries in the audit log such
> as: “avc:  granted  { transition } for  pid=3409 ”. 
> 
>  
> 
> When I run audit2allow on that entry, audit2allow creates a rule for
> that entry as if the entry were a ‘denied’ rather than a ‘granted’. It
> came into being an issue when I was ignoring the allow transition
> entries, and there was an actual ‘denied’ audit (hidden amongst the
> granted transitions [for mls reasons]) that I was not catching when
> manually going through the logs.

That's a bug.  What version of policycoreutils?  Fixed upstream already,
I believe, so bugzilla it against RHEL.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
