Message-ID: <452FF8C2.7080104@hp.com>
Date: Fri, 13 Oct 2006 16:36:18 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Matt Anderson <mra@hp.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        selinux@tycho.nsa.gov
Subject: Re: context_sensitivity_{get|set}
References: <452E955F.2050407@hp.com>	 <1160748247.14346.26.camel@moss-spartans.epoch.ncsc.mil>	 <452FBCF8.2060805@hp.com> <1160757623.14346.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160757623.14346.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-10-13 at 12:21 -0400, Matt Anderson wrote:
> 
>>I agree names are a bit confusing, I was at a loss for what to call them
>>myself and decided to defer to the output from secon:
>>
>># secon
>>user: root
>>role: staff_r
>>type: staff_t
>>sensitivity: SystemLow
>>clearance: SystemHigh
>>mls-range: SystemLow-SystemHigh
>>
>>For my usage I need the entire low level.  There may be other users want
>>just the sensitivity, but I'd be concerned that information would be
>>unintentionally downgraded by leaving off categories.
> 
> 
> I think unfortunately secon and the audit interface were polluted by a
> limited notion of the MLS model.  Proper terms are low level and high
> level, not sensitivity and clearance.

Is it too late to clean up these tools?  With audit, is it just changing
the names of the parameters in some of the user space tools?

-- ljk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
