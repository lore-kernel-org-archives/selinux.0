Sender: Joe Nall <joenall@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Joe Nall <joe@nall.com>
In-Reply-To: <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
Date: Tue, 11 Sep 2018 14:04:51 -0500
Cc: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Message-Id: <2E8FB4B5-598A-4741-9AC6-70C9995A48F9@nall.com>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Sep 11, 2018, at 1:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 09/11/2018 10:41 AM, Stephen Smalley wrote:
>> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>> mcstrans mcscolor.c also uses the same logic I'd been using to check dominance so this too will no longer function as expected on el7. Do you any suggestions for doing a 'generic' (one not tied to a specific resource class) dominance check in lieu of context contains?
>> You should probably define your own permission with its own constraint to avoid depending on the base policy's particular constraint definitions.  Certainly for your own code.  For mcstrans, mcscolor probably ought to be switched to using at least a separate permission in the context class if not its own class to avoid overloading the meaning with pam_selinux's usage (or vice versa, but likely harder to change pam_selinux at this point).
>> It is possible to define an entirely new class, its permissions, and its mls constraints via a CIL module IIUC, without needing to change the base policy.
>> I don't think you can add a permission to an existing class via a CIL module currently, unfortunately, so you can't just extend the context class without modifying the base policy.  So it may be easier to define an entirely new class.
>> The class and permission ought to be specific to the usage.  For example, mcstrans could have its own class (mcstrans) with its own permissions (e.g. color_match or color_use or ...) that abstract away the logical check being performed.  Dominance checks performed for different reasons ought to use different permissions so that one can distinguish what TE pairs are allowed them.
>> Your code could likewise define and use its own class and permission.
>> Does that make sense?
> 
> BTW, I noticed there is another permission ("translate") defined in the context class and its constraint is ((h1 dom h2) or (t1 == mlstranslate)).  I would have guessed that it was intended as a front-end service check over what processes could request context translations from mcstrans or what contexts they could translate, but I don't see it being used in mcstrans anywhere.  Is this a legacy thing from early setransd/mcstransd days?  There is a TODO comment in mcstrans process_request() that suggests there was an intent to perform a dominance check between the requester context and the specified context, but that's not implemented.  Appears to be allowed in current policy for all domains to the setrans_t domain itself.

I think 'translate' predates my mcstransd work and dates from the original TCS implementation. There is an argument to implement that constraint, but we've been operating without it for so long it does not seem worthwhile.

joe
