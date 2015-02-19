Message-ID: <54E63D8A.3040600@tycho.nsa.gov>
Date: Thu, 19 Feb 2015 14:46:18 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
In-Reply-To: <20150219193337.GC12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2015 02:33 PM, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 07:40:48AM PST, Dominick Grift spake thusly:
>> The MCS implementation has been changed a bit over the years on the policy side.
> 
> Is there a RHEL 6 version of the link I pasted below with up to date info?
> Lack of documentation and frequent changes rendering documentation obsolete
> combined with the inherent complexity of something like this are the main
> issues holding back SELinux adoption.
> 
>> Back in the earlier day's MCS was enforced on all proceses in redhat distro's by default
> 
> Yeah...I actually had it working in a test setup in RHEL 5 but never got it
> deployed widely. Now we are trying to redo it with RHEl 6 and running into
> issues.
> 
>> Nowaday's that is no longer the case, and you need to opt-in for it by associating the mcs_constrained_type type attribute with the type of the process to constrain.
>>
>> In rhel6 this attribute name does not exist i suspect. It was renamed to aforementioned later.
>>
>> A seinfo -a | grep mcs might reveal the type attribute used for the same in RHEL6. (i think its something with trusted or untrusted, dunno for sure)
> 
> I don't follow this part... The seinfo output is:
> 
> # seinfo -a | grep mcs
> mcssetcats
> mcswriteall
> mcskillall
> mcsreadall
> mcsnetwrite
> mcsuntrustedproc
> mcsptraceall
> 
> How do these type attributes relate to MCS?

Domains with those attributes can override the corresponding MCS
constraint.  Depending on version, seinfo --constrain will dump the
actual constraints for you.  In any event, I suspect you need to assign
the mcsuntrustedproc attribute to your web application domains if you
want them to be constrained by MCS at all, plus you'd need to run them
with specific category sets.

Or you could use the -mls policy and then only domains marked with
specific mls attributes would be able to override.
