Message-ID: <46098024.1010003@manicmethod.com>
Date: Tue, 27 Mar 2007 16:35:48 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Ryan Bradetich <rbradetich@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
Subject: Re: Separating libselinux/libsepol (Was: Re: BusyBox: load_policy
 applet)
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>	 <1174925566.28830.61.camel@sgc>	 <1174927054.12204.45.camel@localhost.localdomain>	 <1174939981.28830.84.camel@sgc>	 <1174999512.3864.278.camel@moss-spartans.epoch.ncsc.mil>	 <1175010151.29300.39.camel@sgc>	 <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil> <e739902b0703271314o74ded51ek50cba90b6c3d@mail.gmail.com>
In-Reply-To: <e739902b0703271314o74ded51ek50cba90b6c3d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ryan Bradetich wrote:
> On 3/27/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Ok, so what I'm hearing is that we don't need to preserve support for
>> local boolean and user definitions apart from managed policy.  If anyone
>> disagrees, speak up please.
> 
> Please excuse my ignorance, but I do not have a good handle on the
> terms "local boolean" and "user definitions".
> 
> My guess at what you are referring to better encapsulation of booleans
> into the policy modules.  For example:
> 
> The squid_connect_any boolean/tunable is always present in the policy.
> It is not dependent upon if I had disabled squid support in the
> policy.conf file.  One of the advancements I thought was occurring was
> to better encapsulate boolean support into policy modules.  So the
> squid_connect_any boolean/tunable would only be present if the squid
> module was compiled in or as a loaded module.
> 
> I personally like this idea, because it gives me less to review,
> audit, test, and document  before system deployment.  I am not sure if
> this encapsulation idea is what you are referring to as a "local
> boolean", but I can also live without this support.  As Chris
> mentioned, I would just modify the policy to remove all the booleans
> that are not relevant to my system before deployment.
> 
> Is this the support you are looking to remove?  Or do you mean something 
> else?
> 

Something else. What you mentioned is a policy issue and the discussion 
is about the toolchain/libraries. The local boolean support was added 
before modular policy was added that lets users set boolean values 
persistently locally and init/load_policy (through libselinux) read a 
flat text file with the boolean values and set them in the in-memory 
policydb before loading it into the kernel.

Modular policy has removed the need to modify policies at load time by 
rebuilding the binary from the modules and all local settings (users, 
ports, nodes, booleans, etc). We sought to remove the in-memory 
modification to policies so that we could analyze the actual policy 
binary being used on the system and not something that would be modified 
before being loaded. It also allowed us to add more flexibility by way 
of semanage that was not there previously.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
