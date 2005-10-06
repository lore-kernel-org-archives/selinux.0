Message-ID: <43454D9F.7000109@tresys.com>
Date: Thu, 06 Oct 2005 12:15:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] permission value inconsistency
References: <1128436261.28919.6.camel@twoface.columbia.tresys.com> <1128528046.24059.195.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128528046.24059.195.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-10-04 at 10:31 -0400, Joshua Brindle wrote:
> 
>>These patches fix permission and common permission values being
>>incremented before they were successfully added. This may cause an
>>inconsistency in the policy in the error case.
> 
> 
> Isn't the error case fatal anyway?
> 

Yes, the error case is fatal but there may be a possibility of an 
invalid free when destroying the policydb and it certainly doesn't hurt 
anything to keep the policydb consistent an an error case.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
