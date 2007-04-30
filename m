Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEfsHq031288
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:41:54 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UEfrbP028194
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:41:53 GMT
Received: by wx-out-0506.google.com with SMTP id s17so438828wxc
        for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 07:41:54 -0700 (PDT)
Message-ID: <4636002F.5000100@gmail.com>
Date: Mon, 30 Apr 2007 09:41:51 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: launching apps at level (MLS) and polyinstantiation
References: <463243E3.2060602@gmail.com>	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>	 <463360B0.7020106@gmail.com> <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2007-04-28 at 09:56 -0500, Ted X Toth wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Fri, 2007-04-27 at 15:01 -0400, Stephen Smalley wrote:
>>>   
>>>       
>>>> On Fri, 2007-04-27 at 13:41 -0500, Ted X Toth wrote:
>>>>     
>>>>         
>>>>> I'm working on an application that launches other applications at a 
>>>>> specified level. I have also configured polyinstantiation for a some 
>>>>> directories. What I have found is that I had to make this application 
>>>>> pam aware in order for the child process to get polyinstantiated 
>>>>> directories. One issue is the reauthentication I've already 
>>>>> authenticated why should I have to reauthenticate so that a child 
>>>>> process can use polyinstantiated directories? Currently this app works 
>>>>> when run as root but not as other users because the unshare call in 
>>>>> pam_namespace fails for lack of permissions (CAP_SYS_ADMIN?). What do I 
>>>>> need to do so that the application has this capability? I tried making 
>>>>> the app setuid but that didn't help.
>>>>>       
>>>>>           
>>>> First, your application sounds similar to newrole -l, so hopefully you
>>>> can draw from it.
>>>>     
>>>>         
>>> In fact, newrole -l <level> -- -c <app> will run an application in a
>>> given level.
>>>
>>>   
>>>       
>>>> What precisely requires your app to perform authentication?  You control
>>>> your app's pam config, so you can define those modules as you see fit,
>>>> including using trivial ones like pam_permit.so.  And you control
>>>> whether your app calls pam_authenticate().  Possibly you may need to set
>>>> up state to make pam_open_session() happy.
>>>>
>>>> newrole has the same issue wrt needing capabilities, so look to it as an
>>>> example - look at the NAMESPACE_PRIV code.  It needs to be suid but also
>>>> needs to run in a domain that is allowed those capabilities.
>>>>
>>>>     
>>>>         
>> Would it be reasonable to extend newrole by adding a parameter for the 
>> pam service name so that different authentication strategies could be 
>> employed?
>>     
>
> That would be dangerous - a user could then pick any pam service name he
> wants and run newrole with that, e.g. to bypass some aspect of the
> newrole pam stack.
>
> But you are certainly free to customize /etc/pam.d/newrole on your
> systems as you like.
>   
We wouldn't want to change newroles pam configuration across the board like that we're looking to be able to reuse its capability in more flexible ways. You could limit which pam configurations that could be used by defining a policy attribute and only allowing newrole access to files with that attribute, right? Another idea is to have a configuration file that would map service names to applications being run under newrole.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
