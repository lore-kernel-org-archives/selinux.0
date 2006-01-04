Message-ID: <43BC0D12.1020000@tresys.com>
Date: Wed, 04 Jan 2006 12:59:46 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
References: <43BBD6C0.6020108@cornell.edu> <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-01-04 at 09:08 -0500, Ivan Gyurdiev wrote:
> 
>>Hi, Steven pointed out (off-list) that libsemanage vs libsepol behavior 
>>is inconsistent with respect to set/add/modify.
>>In libsemanage, the object being added becomes "managed" by the library, 
>>while this is not true in libsepol. We decided it was better to have the 
>>client control the object passed in, and be responsible for freeing it.
>>
>>This patch makes the appropriate changes (which include reversal of some 
>>of the code from the other patches) to implement that.
>>It also includes a bugfix for the error path of 
>>database_policydb.c:list, pointed out by Russel Coker.
> 
> 
> Thanks, your entire patch series has been merged as of libsepol 1.11.2,
> libsemanage 1.5.4, and policycoreutils 1.29.3.
> 

Ivan, were you going to add tests for the wrappers to pywrap-test?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
