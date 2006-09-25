Message-ID: <451825CD.8030409@hp.com>
Date: Mon, 25 Sep 2006 14:54:05 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>	 <1159196366.3450.13.camel@localhost.localdomain>	 <1159207118.15305.51.camel@moss-spartans.epoch.ncsc.mil> <1159209499.4741.43.camel@localhost.localdomain>
In-Reply-To: <1159209499.4741.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Mon, 2006-09-25 at 13:58 -0400, Stephen Smalley wrote:
>>On Mon, 2006-09-25 at 10:59 -0400, Karl MacMillan wrote:
>>>The choices I see are:
>>>
>>>    1) Leave netlabel and ipsec as packet labeling _only_. Somehow 
>>>       reconcile / prioritize the various packet labels.
>>>
>>>    2) Make netlabel and ipsec transmit the sending domain context 
>>>       _only_. Somehow reconcile the various domain labels.
>>>
>>>    3) Allow ipsec to transmit 2 contexts or designate that Netlabel 
>>>       passes 1 kind of remote label and ipsec transmits the other 
>>>       (e.g., netlabel labels the packet while ipsec transmits the 
>>>       sending domain context).
>>
>>I thin the only real choices are:
>>1) Add a separate field to the sk_buff for use by labeled networking so
>>that we don't have to overload secmark in this manner, or
>  
> This has the advantage of at least being clear, easy to explain, and
> easy to debug for a user. The disadvantage, of course, is that you end
> up with more policy.
> 
> I would rather see more allow rules that are clear than more transition
> rules that are subtle and only take effect in some circumstances,
> though.
> 
>>2) Deal with the secid reconciliation, but work out the policy
>>implications.
> 
> Like I said above, I think you are correctly pointing out that this is a
> deeper issue than labels and the policy implications are going to be
> hard. The division between what logic is pushed into the labeling
> mechanism and what logic is pushed into the object class permissions is
> too different.
> 
> I think that we should go for 1 and have getpeercon return the label
> from the labeled networking.

Unfortunately I don't think the netdev folks will like/accept adding
another field to the sk_buff structure.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
