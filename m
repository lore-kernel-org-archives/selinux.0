Message-ID: <54E6472E.1060800@tycho.nsa.gov>
Date: Thu, 19 Feb 2015 15:27:26 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org> <54E63D8A.3040600@tycho.nsa.gov>
 <20150219201720.GE12937@tracyreed.org>
In-Reply-To: <20150219201720.GE12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2015 03:17 PM, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 11:46:18AM PST, Stephen Smalley spake thusly:
>> Domains with those attributes can override the corresponding MCS
>> constraint.  Depending on version, seinfo --constrain will dump the
>> actual constraints for you.  In any event, I suspect you need to assign
>> the mcsuntrustedproc attribute to your web application domains if you
>> want them to be constrained by MCS at all, plus you'd need to run them
>> with specific category sets.
> 
> How do I assign mcsuntrustedproc attribute to my web application domain? I know
> how to set booleans, categories, etc. but have not yet encountered needing to
> set an attribute for a domain. Google for "set selinux attribute" turns up
> stuff about setting user, role, type etc. as attributes but nothing about
> setting attributes such as mcsuntrustedproc.

You need to create a policy module and install it.

You can either use the refpolicy interface for making it MCS constrained
(look in /usr/share/selinux/devel/include/kernel/mcs.if after installing
selinux-policy-devel), or just directly put a typeattribute statement
into your policy module.
