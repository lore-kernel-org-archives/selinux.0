Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l9NH83TW018933
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 13:08:03 -0400
Message-ID: <471E2A72.2090903@tycho.nsa.gov>
Date: Tue, 23 Oct 2007 13:08:02 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: trouble with ssh in today's rawhide + refpolicy
References: <471D1596.8070900@tycho.nsa.gov> <1193144985.9466.53.camel@gorn>
In-Reply-To: <1193144985.9466.53.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
>> On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
>> mode, I get the following after rebooting the box and logging in over ssh:
>>
>> $ id -Z
>> sysadm_u:sysadm_r:system_chkpwd_t:s0
> 
> Do you have ssh_sysadm_login on?

Nope, didn't have this set.  That solves the problem, thanks.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
