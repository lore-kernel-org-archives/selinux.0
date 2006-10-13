Subject: Re: context_sensitivity_{get|set}
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linda Knippers <linda.knippers@hp.com>
Cc: Matt Anderson <mra@hp.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <452FF8C2.7080104@hp.com>
References: <452E955F.2050407@hp.com>
	 <1160748247.14346.26.camel@moss-spartans.epoch.ncsc.mil>
	 <452FBCF8.2060805@hp.com>
	 <1160757623.14346.84.camel@moss-spartans.epoch.ncsc.mil>
	 <452FF8C2.7080104@hp.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 16:54:39 -0400
Message-Id: <1160772879.14346.228.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-13 at 16:36 -0400, Linda Knippers wrote:
> Stephen Smalley wrote:
> > On Fri, 2006-10-13 at 12:21 -0400, Matt Anderson wrote:
> > 
> >>I agree names are a bit confusing, I was at a loss for what to call them
> >>myself and decided to defer to the output from secon:
> >>
> >># secon
> >>user: root
> >>role: staff_r
> >>type: staff_t
> >>sensitivity: SystemLow
> >>clearance: SystemHigh
> >>mls-range: SystemLow-SystemHigh
> >>
> >>For my usage I need the entire low level.  There may be other users want
> >>just the sensitivity, but I'd be concerned that information would be
> >>unintentionally downgraded by leaving off categories.
> > 
> > 
> > I think unfortunately secon and the audit interface were polluted by a
> > limited notion of the MLS model.  Proper terms are low level and high
> > level, not sensitivity and clearance.
> 
> Is it too late to clean up these tools?  With audit, is it just changing
> the names of the parameters in some of the user space tools?

Also affects the kernel definitions (include/linux/audit.h), if you want
consistent naming all the way down.  Not sure it is worth it.
At present, audit uses sensitivity/clearance to talk about the subject
low/high levels, but refers to the object levels as just low/high.

Also, likely need to distinguish here between the interface we present
to users versus the application interfaces.  I suppose audit and secon
could ultimately support some kind of per-policy configuration for
naming the label components in a way that matches the user expectations
for that policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
