Message-ID: <45C8E7A2.4070604@mentalrootkit.com>
Date: Tue, 06 Feb 2007 15:40:02 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] add sepolgen
References: <45C0C722.4030604@mentalrootkit.com> <1170701985.12293.317.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170701985.12293.317.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-01-31 at 11:43 -0500, Karl MacMillan wrote:
>> The patch at [1] adds the sepolgen python library for policy generation 
>> and a new implementation of audit2allow based on this library. The 
>> library has facilities for:
>>
>> * parsing audit messages
>> * parsing and representing policy (including refpolicy interfaces)
>> * manipulating / transforming policy (e.g., adding require statements)
>> * generating policy from access requests / audit messages (including 
>> calls to refpolicy interfaces)
>> * outputting policy as text
>> * compiling policy modules
>>
>> All of the requested updates from the previous review have been made.
>>
>> Notes for packaging:
>>
>> * This adds a new dependency between policycoreutils and sepolgen
>> * The tool sepolgen-ifgen needs to be run to extract information from 
>> the reference policy headers for audit2allow to generate refpolicy. The 
>> rpm spec file at 
>> http://hg.et.redhat.com/selinux/madison?f=b26375c7641a;file=madison.spec 
>> shows how I did this.
>> * Audit2allow currently has a few regressions from the old version. This 
>> will be fixed soon.
>>
>> [1] 
>> http://people.redhat.com/kmacmill/patches/selinux/sepolgen-initial-submission.patch.gz
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> Thanks, merged on the trunk.  Please check that it is complete and
> up-to-date with your own tree.
> 

Looks correct and up-to-date with all of the completed patches.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
