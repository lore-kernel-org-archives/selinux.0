Message-ID: <465C79B3.6050501@tycho.nsa.gov>
Date: Tue, 29 May 2007 15:06:27 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: object class discovery userland
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil>	 <1179929852.10995.51.camel@sgc.columbia.tresys.com> <1180462767.3340.116.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180462767.3340.116.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-05-23 at 14:17 +0000, Christopher J. PeBenito wrote:

>> The object manager will also have to be modified to get the new class
>> and perm values on a policy reload.
> 
> Why not just require them to remain stable at runtime, and require a
> restart of the object manager if you are going to change them?  Allowing
> them to change at any time will introduce a fair amount of
> complexity/overhead at runtime.
> 

I'm fine with this, however I think it should be the kernel's job to 
enforce the stability of the values.  The policyload should fail if the 
values are changing.

Perhaps this could be a configurable "experimental" versus "production" 
option, or perhaps userspace object managers could somehow register with 
the kernel which will then refuse to change the values if any are 
currently running.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
