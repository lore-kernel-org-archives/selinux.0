Message-ID: <452FBC4B.2060703@hp.com>
Date: Fri, 13 Oct 2006 12:18:19 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Matt Anderson <mra@hp.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: context_sensitivity_{get|set}
References: <452E955F.2050407@hp.com> <1160748247.14346.26.camel@moss-spartans.epoch.ncsc.mil> <20061013154729.GI28525@w-m-p.com>
In-Reply-To: <20061013154729.GI28525@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Fri, Oct 13, 2006 at 10:04:07AM -0400, Stephen Smalley wrote:
> 
>>On Thu, 2006-10-12 at 15:19 -0400, Matt Anderson wrote:
>>
>>>For my latest CUPS patch I needed to include code that set the
>>>sensitivity of the spool file storing the to that of the client's
>>>context when they queued the job.  I used context_range_get() to
>>>retrieve the MLS range, but then had to use strtok() to get the lower bound.
>>>
>>>Is context_sensitivity_get() or context_sensitivity_set() a function
>>>that other consumers might need?  Should it be included in libselinux?
>>
>>Providing functions to get/set the low and high would make sense (and
>>newrole already has to do similar processing internally for newrole -l),
>>but I don't follow the function names above - do you want just the low
>>sensitivity (i.e. no categories) or the entire low level?  And you need
>>to indicate whether you are operating on the low or the high levels in
>>the interface.
>  
> The terminology is confusing, and it doesn't help that the LSPP document
> combines the terms in creative ways. It uses "sensitivity label" and
> "security level" to refer to the full set, and generally includes the
> term "hierarchical" when referring to the non-category part only.
> 
> My preference would be to have separate functions for the high level,
> maybe including "clearance" in the name, since that's generally
> appropriate for subjects only. I'd consider it a bug to assign level
> ranges to objects - they should have either a single level or be a
> trusted object. I think the symmetry in the current implementation is a
> bit of a distraction...
> 
> How about context_mlslevel_get/set() for objects and the effective level
> of subjects, and context_mlsclearance_get/set() for the high level of
> subjects?  (I'm not saying it needs to actually enforce the
> subject/object distinction, people can use the clearance function to set
> the high level of objects if they insist.)

I agree with Klaus about the "high" portion of the MLS label really being more
of a clearance and the "low" portion being the effective.  However, since these
new library functions would operate strictly on a context and not on the object
itself I wonder it we would be better served by sticking with the more abstract
names of context_mlslow_{get,set}() and context_mlshigh_{get,set}()?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
