Message-ID: <46A11BC4.10106@redhat.com>
Date: Fri, 20 Jul 2007 16:32:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: Proposed patch to lisemanage/policycoreutils patches to not	run
 genhomedircon/setfiles when setting booleans.
References: <469E6FFF.3040009@redhat.com> <1184954124.17338.868.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1184954124.17338.868.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-07-18 at 15:54 -0400, Daniel J Walsh wrote:
>   
>> Takes about 2 seconds off the time to rebuild policy and lots more if 
>> you are backending your passwd database with ldap.  Or have many 
>> different locations for homedirs.
>>     
>
> The way this should work is libsemanage should internally know what
> needs to be rebuilt and only rebuild those things.  Not require the
> caller to enable/disable parts.
>  
>   
I tend to agree, but this at least meets my short term goals.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
