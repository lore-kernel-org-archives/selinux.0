Message-ID: <43F5F88A.8040702@trustedcs.com>
Date: Fri, 17 Feb 2006 10:23:38 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: dustin.kirkland@us.ibm.com
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC] [PATCH]
References: <43F49805.2000109@trustedcs.com>	 <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>	 <43F4DBE0.3060204@trustedcs.com>	 <1140122205.12655.171.camel@moss-spartans.epoch.ncsc.mil>	 <43F5E12E.70003@trustedcs.com> <1140192267.3083.119.camel@kirkland1.austin.ibm.com>
In-Reply-To: <1140192267.3083.119.camel@kirkland1.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dustin Kirkland wrote:
> On Fri, 2006-02-17 at 08:43 -0600, Darrel Goeddel wrote:
> 
>>It would seem to me that we need the current functionality of keeping all rules
>>that are set up and revalidating them upon policy loads.  If we don't do it here,
>>it would need to be done at the audit layer - it might not be as pretty there.
> 
> 
> 
> I don't know...  My first thoughts are that it seems like the audit
> layer should be ignorant of policy loads/reloads--that's not really it's
> business.

I was trying to avoid knowledge of policy reloads (and really policy in general)
with the rule skipping piece and the sequo checking when the rule is used.  As
far as the audit system is concerned, SELinux could be rolling dice to determine
matches.

As for the big picture.  Steve Grubb suggested a compromise of keeping the current
methodology and enhancing it with KERN_INFO messages.  I'd suggest message for the
following:

- a rule that is inactive is inserted
- a rule that was active becomes inactive
- a rule that was inactive becomes active

Does that fit the bill?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
