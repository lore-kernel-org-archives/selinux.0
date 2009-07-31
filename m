Message-ID: <4A72E657.2050808@redhat.com>
Date: Fri, 31 Jul 2009 08:40:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Cliffe <cliffe@ii.net>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        slide@tresys.com, Christopher Pardy <cpardy@redhat.com>
Subject: Re: Help with SELinux policy for Usability Study
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>	 <4A711890.2030101@ii.net>	 <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>	 <4A71AD1A.5030406@ii.net> <1248965089.11627.137.camel@moss-pluto.epoch.ncsc.mil> <4A71D8CE.1010700@redhat.com> <4A724FA0.9010001@ii.net>
In-Reply-To: <4A724FA0.9010001@ii.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/30/2009 09:57 PM, Cliffe wrote:
> Daniel J Walsh wrote:
>> BTW, if you use the sepolgen command line that is in F11 and Rawhide,
>> it has new features to examine the executable and rpm information to
>> generate more data automatigically.  It is using the same framework
>> that polgengui is using.
>> You can execute
>>
>> sepolgen /usr/sbin/myapp
>>
>> And it will generate the myapp,te, if, fc, sh file automatically, No
>> gui to walk though.
>>
>> For example it will look for paths in the rpm that match
>> /var/run/myapp, /var/lib/myapp ... and create proper types.
>> It also runs nm -D /usr/sbin/myapp looking for function calls that it
>> knows require certain interfaces,  If it find syslog it will add the
>> logging_send_syslog_msg(myapp_t)
>> call.
>>
>> I have not merged this stuff back into the GUI yet.
>>   
> 
> Thanks. They sound like helpful features. They sound similar to some of
> the techniques my own tool uses.
> 
> I tested sepolgen with a few apps. Since the results still require a
> very similar amount of manual editing it is probably fairest to use the
> gui tool as much as possible as the other systems participants will use
> all use gui policy management tools.
> 
> Some information about the study:
>    - Participants will be shown a prerecorded explanation and
> demonstration of SELinux
>    - And have a limited amount of time to confine some programs
>    - I don't want to go into too much detail here until the study is
> complete
> 
> Justification for using polgengui:
>    - It ships standard with fedora
>    - It has a gui (like the other tools they will be using)
>    - It has a short learning curve (as opposed to perhaps SLIDE, which
> appears to be a more comprehensive tool for policy design but maybe not
> as suited to the average user)
> 
> Some questions:
> Does SLIDE automate more of the process, such as adding to the created
> policy?
> Is there a tool or command to put a domain into enforcing mode rather
> than manually editing the .te file? (system-config-selinux seems to
> think it is already in enforcing mode)
> 
> Some suggestions:
> It might be a good idea to make the gui tools such as setroubleshoot
> aware of permissive domains, as it simply says that selinux enforcing
> mode is on.
Currently the information is there in the avc, success=True, indicates that the AVC while reported, did not cause the SYSCALL to fail, usually this means either the domain or system is in permissive mode.  Currently setools does not reveal
whether a domain is permissive or not,  this is something we want to add.  The setroubleshoot could reveal this.
> It may be a good idea to create a gui tool which steps users through the
> process of adding to a .te file using audit2allow (if one doesn't exist
> already).
> 
Patches welcome.  :^)

We have thought about this, but currently do not have the cycles.

> Christopher Pardy wrote:
>> Please CC me any results you find as well as any issues with the gui
>> tools as I'm revamping them for F12.
>>   
> Sure. Participants will give feedback such as suggestions for improvement.
> 
> Thanks again everyone for your advice and suggestions,
> 
> Cliffe.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
