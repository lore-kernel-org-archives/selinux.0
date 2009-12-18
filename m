Message-ID: <4B2BA1F4.6090709@manicmethod.com>
Date: Fri, 18 Dec 2009 10:38:28 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        jmorris@namei.org, selinux@tycho.nsa.gov,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Dynamic port labeling V2
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B181228.6080600@manicmethod.com>	 <1259937021.2444.16.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B1932EB.9020303@manicmethod.com> <1260206511.2630.10.camel@moss-stripedbass.epoch.ncsc.mil>
In-Reply-To: <1260206511.2630.10.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Nuzzi wrote:
> On Fri, 2009-12-04 at 11:03 -0500, Joshua Brindle wrote:
>> effect at once.
>>
>> I don't know though, I may be overthinking this. Right now isn't ideal,
>> portcons have to be stored in a libsemanage "database" and they get
>> added to the policydb at policy build time. You could generate out a
>> portcon file that sits next to the policy.24 and gets fed in at load
>> time but making modifications to that and keeping them in sync would be
>> a pain, unless libsemanage made the change and regenerated the file (it
>> would be cheaper than rebuilding the entire policy) but that would also
>> mean you'd have to modify libsemanage which I typically don't wish on
>> anyone.
>>
>
> Sounds like your idea would present some a few problems.  To implement
> this functionality user-space would have to take out a policy lock in
> the kernel for an indefinite amount of time.  That brings up some issues
> on scalability.  Typically atomic operations are small and fast.  This
> also sounds like a toolchain issue.  The proposed functionality can be
> done in the front end of semanage or setportcon.
>

Thanks to Kyle for digging this thread back up.

I understand there are issues (though I disagree with your assertion 
above wrt policy lock, you'd just need to fill in an ocontext and take a 
lock to switch the pointer IIUC). I don't like this "well, its a 
toolchain issue". Sure it is, and the toolchain issue should be solved 
before the kernel code goes forward.

Adding something to the kernel and then figuring out how to use it in 
userspace later is a recipe for disaster, at best it accidentally works 
but at worst the userspace interface is broken and cumbersome or the 
kernel part has to be completely rewritten to work the way userspace 
needs it to.

Not that you need my ACK but I'd need to see the expected userspace 
interface and how it works with the kernel interface to support this.

The expected userspace interface from my perspective would be semanage 
since we already have multiple ways of setting portcons and adding 
another hurts usability.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
