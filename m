Date: Fri, 12 Oct 2007 19:38:01 -0400
Subject: Re: concept of a permissive domain
From: Chad Sellers <csellers@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, <selinux@tycho.nsa.gov>
Message-ID: <C3357D99.2F091%csellers@tresys.com>
In-Reply-To: <1192224105.3294.62.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/12/07 5:21 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:

> On Fri, 2007-10-12 at 16:43 -0400, Chad Sellers wrote:
>> On 10/12/07 3:05 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:
>> 
>>> On Fri, 2007-10-12 at 14:40 -0400, Chad Sellers wrote:
> 
> [...[
> 
>>> 
>>> Calling it a permissive domain uses the same concept as global
>>> permissive - so I think that is natural. It does not, to me, mean that
>>> it should be enabled in the same way as global permissive - that's just
>>> an implementation detail. I think it is much better to put it in the
>>> policy as that allows some sort of sane delivery mechanism.
>>> 
>> Calling it one thing and implementing it differently is fine as long as the
>> implementation doesn't leak out to the user. And it will here. We're not
>> exactly good at making leak-proof abstractions to begin with, but this is a
>> case where the user will see a new statement in policy.
>> 
>> Think of this from the perspective of the user. We have to tell them that
>> system-wide permissive is not part of policy, but is instead in a config
>> file, done using setenforce, or done using selinuxfs, but per-domain
>> permissive is not done by any of those methods, but instead is done in
>> policy via a new language construct. This is confusing.
>> 
>> Chad
> 
> See, now you are going to make me argue for putting permissive in the
> policy, which I think that it should be. The fact that we have
> permissive in a separate config file, have to write a little parser in
> libselinux, patch apps to set permissive on boot is just dumb.
> 
I figured that might be your response. I actually don't mind that solution
at all. I'm just trying to minimize the number of different concepts in
SELinux.

> That doesn't mean when shouldn't allow small changes to the in-kernel
> policy - like switching permissive on or off - but I still think it
> makes no sense to have one big configuration file with lots of tiny
> supporting config files. Just put it all in one place and be done with
> it.
> 
Note that we already have a mechanism for turning pieces of policy on/off
in-kernel (booleans). So, if permissive were policy based, we could
potentially simplify things by having the kernel "switch" be just another
boolean instead of a separate mechanism.

Chad

> Karl
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
