Message-ID: <45757B34.5050209@mentalrootkit.com>
Date: Tue, 05 Dec 2006 08:59:16 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC] Ability to allow unknown class and permissions
References: <6FE441CD9F0C0C479F2D88F959B015885C82D7@exchange.columbia.tresys.com>	 <1165263959.2923.148.camel@moss-spartans.epoch.ncsc.mil>	 <45748652.4050100@mentalrootkit.com>	 <1165265045.2923.168.camel@moss-spartans.epoch.ncsc.mil>	 <45748D8D.8040500@mentalrootkit.com> <1165325510.15979.6.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1165325510.15979.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-12-04 at 16:05 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>> See above.
> 
> You still need validation in the kernel, and the policy would still lack
> kernel classes and/or permissions unless libsemanage/libsepol is also
> inserting fake entries for the missing ones, so how would the kernel
> handle missing classes and permissions?  How would it know that
> userspace had already padded the avtab for them?
> 
> I'm unconvinced that this approach is simpler overall compared to direct
> kernel implementation at load time.
> 

You may be right and I don't feel that strongly about it. I was really 
just hoping that the discovery interface would finally get done.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
