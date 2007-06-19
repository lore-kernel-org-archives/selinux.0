Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JGBfMA018343
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 12:11:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JGBeZO006938
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 16:11:40 GMT
Message-ID: <46780038.9040208@redhat.com>
Date: Tue, 19 Jun 2007 12:11:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Per Domain Permissive Mode
References: <4677EE5B.9030405@redhat.com>	 <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>	 <Line.LNX.4.64.0706191118420.15755@localhost.localdomain> <1182267849.21615.103.camel@localhost.localdomain>
In-Reply-To: <1182267849.21615.103.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-06-19 at 11:19 -0400, James Morris wrote:
>   
>> On Tue, 19 Jun 2007, James Morris wrote:
>>
>>     
>>> On Tue, 19 Jun 2007, Daniel J Walsh wrote:
>>>
>>>       
>>>> Thoughts...
>>>>         
>>> We can do this in policy: define a domain which runs with all accessess 
>>> allowed, and also optionally logged for profiling purposes.
>>>       
>> Actually, this is not entirely useful for development -- perhaps some kind 
>> of abstraction can be used to hide all of the allow rules, so it just 
>> appears to the policy developer that the domain is in permissive mode.
>>
>>     
>
> The complicated bit is actually the auditallow rules to get similar
> auditing to permissive. We only want to add auditallow rules for the
> extra access allowed to make the domain unconfined not for all access
> allowed by the domain. That basically means parsing the module, figuring
> out what was allowed, and adding auditallow for the difference between
> that access and unconfined.
>
> Sepolgen is almost at a point it can do this. Slide, as far as I know,
> doesn't parse the access in sufficient detail to do this yet.
>
> One downside to this approach is teaching policy generation tools to
> generate access for granted messages in the log. It also makes explicit
> auditallow somewhat useless.
>
> Karl
>
>   
One interesting twist would be if dontaudit rules were enforced.  For 
example when an app uses pam, it attempts to read/write /etc/shadow.
Most apps have this dontaudited so a different code path gets walked 
within pam.  If we just run the app totally in permissive mode, the app
will not hit this code path, until it gets out in the wild in enforcing 
mode.


So the algorithm should be something like the following

newallowrules = unconfined_domain - ( allowrules + dontauditrules )

permissiveconfineddomain = newallowrules + allowrules + dontauditrules + 
{ auditallow newallowrules }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
