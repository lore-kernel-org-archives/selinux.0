Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CEtupE010230
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 10:55:56 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CEts1i013463
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 14:55:55 GMT
Message-ID: <4464A251.6060802@redhat.com>
Date: Fri, 12 May 2006 10:57:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: AVC Decision Tree.
References: <442C36AF.4090001@redhat.com> <1147268099.19334.15.camel@sgc>	 <44622F15.9010205@redhat.com>  <1147285742.19334.19.camel@sgc> <1147444886.19334.40.camel@sgc.columbia.tresys.com>
In-Reply-To: <1147444886.19334.40.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> (accidentally went off list with this)
>
> On Wed, 2006-05-10 at 14:29 -0400, Christopher J. PeBenito wrote:
>   
>> On Wed, 2006-05-10 at 14:21 -0400, Daniel J Walsh wrote:
>>     
>>> Christopher J. PeBenito wrote:
>>>       
>>>> On Thu, 2006-03-30 at 14:51 -0500, Daniel J Walsh wrote:
>>>>   
>>>>         
>>>>> http://fedoraproject.org/wiki/SELinux/Troubleshooting/AVCDecisions#preview
>>>>>
>>>>> Trying to build a analysys tool to be able to translate avc messages 
>>>>> into possible boolean/file_context solutions.
>>>>>
>>>>> The idea is that we can look at the AVC messages that are generated and 
>>>>> figure out what the servers were trying to do.  Then we can give some 
>>>>> advise to the administrator on the corrective measures.  So what we are 
>>>>> looking for are expected code paths where there is a file context of 
>>>>> boolean available.
>>>>>     
>>>>>           
>>>> We had a meeting since the conversion of example policy is wrapping up,
>>>> and we're looking at adding this type of information to reference policy
>>>> XML.  Then the tree doesn't have to be hard coded, so a tool could load
>>>> up the XML and gather denials, and then if you got an etc_t:file read
>>>> denial, the decision tree should come up with files_read_etc_files().
>>>>
>>>>   
>>>>         
>>> But that is not what we are after.  I have attached an example plugin, 
>>> which translates an AVC message about ftp into one of two possible 
>>> messages. 
>>>       
>> Thats included in what we were thinking.
>>     
>
> To expand, the idea would be to eventually have something like an
> audit2interface tool.  It would be much better than the current
> audit2allow, not only because it resolves to interfaces or boolean
> toggles, but it allows an opportunity to give the user information about
> what the rules do.  With audit2allow, users just see a pile of rules and
> have no clue what it means or if its safe, whereas leveraging the
> information in the interface xml, the tool can present them with much
> more information about risks with allowing the access and give the
> opportunity to dontaudit instead.
>
>   

This sounds good,  I actually use the audit2allow -R all the time, and 
for a hack it works pretty well.
But an improvement in this would be great.  I think if we can get better 
descriptions and problem
resolutions that users could understand it would be a huge improvement.  
My concern is translations.
We are currently working on an interface to be able to translate AVC and 
present them to the user.  
These need to be translated.  Now we could probably extract the 
descriptions out of the policy and
allow them to be translated for our tool.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
