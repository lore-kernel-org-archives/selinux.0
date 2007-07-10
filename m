Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6A9l8Ws029116
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 05:47:08 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6A9l65L020499
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 09:47:07 GMT
Received: by wa-out-1112.google.com with SMTP id k22so1489157waf
        for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 02:47:06 -0700 (PDT)
Message-ID: <46935489.1020507@gmail.com>
Date: Tue, 10 Jul 2007 17:42:33 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Louis Lam <lshoujun@yahoo.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Newbie: Using SELINUX to contain vmware
References: <965615.33439.qm@web34812.mail.mud.yahoo.com>
In-Reply-To: <965615.33439.qm@web34812.mail.mud.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Louis Lam wrote:
> Hi,
> 
> I managed to compile the vmware.pp, but not using the latest reference policy. The vmware.if file
> on Centos5 matched the ref policy dtd 20061018. So i managed to compile the module.
> 
> But when i tried to load the module i get a denied message in the setroubleshoot browser. So i
> copied the vmware.pp into /etc/selinux/targeted/modules/active/modules/ and fixed the context to
> be the same as the other modules and successfully loaded it without errors. Is this the correct
> way to do it? i'm not too sure.

what the error messages you have?

i used the same way to install vmware.pp, there is not any avc errors

> 
> I got an error doing restorecon:
> restorecon -R -v "vmware relative directories"
> restorecon: error while labeling files under vmware relative directories

you can not use this method to install module, "semodule -i" will not
only modify fc context, but recompile policy and commit changes into
kernel policydb as well. i think this is also the reason restorecon fails

> 
> I don't see any other error messages that explains this failure, what could be the cause? Is it
> logged somewhere?
> 
> Hi Ken, would you be able to share which Distribution (FC?) you're using and also the reference
> policy version that enabled you to contain vmware? I'd like to try to get it to work first then
> figure out how to port it back to Centos5/RHEL5 once i get it to work.

i am using the "merged" version selinux policy:

selinux-policy-targeted-3.0.2-3.fc8.noarch

but it seems to have some problems about vmware:

http://marc.info/?l=fedora-selinux-list&m=118405414713655&w=2


the "working" policy version is selinux-policy-targeted-2.6.4-25.fc7:

http://koji.fedoraproject.org/koji/buildinfo?buildID=10131


> 
> Thanks in advance,
> Louis
> 
> 
> 
> --- Ken YANG <spng.yang@gmail.com> wrote:
> 
>> Louis Lam wrote:
>>> Hi,
>>>
>>> I was trying this on a Centos05 system, assuming that it was built upon the same sources as
>> RHEL5:
>>> I've installed the selinux-policy-devel rpm. can't find the vmware.pp module. Source wise
>> there is
>>> only a vmware.if file. No vmware.te or vmware.fc. I'm not sure why these two files are not
>>> included  since all three are needed to make the vmware.pp module. 
>> devel package only contains interface files, just as other "*devel"
>> package, which only include header files.
>>
>> so selinux-policy-devel only contains vmware.if file.
>>
>> Perhaps someone who is
>>> experienced on RHEL5/CENTOS can shed light on the reason why only the vmware.if is included?
>>>
>>> Then I read somewhere that policygentool can be used to generate all the three files
>>> (.if,.te,.fc). I'll try this approach too.
>>>
>>> BUT in this case where I were to try the method that Ken suggested below (Thanks Ken!). I'm
>> using
>>> the files from "http://oss.tresys.com/repos/refpolicy/trunk" .In this case i already have all
>> the
>>> three files, I could just use make on them to generate the pp right?
>>>
>>> But when i try to do make I get the following errors that I don't seem to understand:
>>>
>>> make -f /usr/share/selinux/devel/Makefile
>>> vmware.if:168: Error: duplicate definition of vmware_per_role_template(). Original definition
>> on
>>> 16
>>> 9.
>>> vmware.if:186: Error: duplicate definition of vmware_read_system_config(). Original definition
>> on
>>> 1
>>> 87.
>>> vmware.if:204: Error: duplicate definition of vmware_append_system_config(). Original
>> definition
>>> on
>>>  205.
>>> Compiling targeted vmware module
>>> /usr/bin/checkmodule:  loading policy configuration from tmp/vmware.tmp
>>> vmware.te:38:ERROR 'syntax error' at token 'manage_files_pattern' on line 78147:
>>> # cjp: the ro and rw files should be split up
>>> manage_files_pattern(vmware_host_t,vmware_sys_conf_t,vmware_sys_conf_t)
>>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>>> make: *** [tmp/vmware.mod] Error 1
>>>
>>> Not very sure what is going on here, pl help. I'm thinking there may be some conflict between
>> the
>>> vmware.if from the selinux-policy-devel rpm and the one downloaded from
>>> http://oss.tresys.com/repos/refpolicy/trunk
>> using Makefile to build vmware.pp, you already have vmware interface
>> file(in selinux-policy-devel), and you get vmware.[if,fc,te] from trunk,
>> so there are duplicate definition errors.
>>
>> in /usr/share/selinux/devel/include/Makefile:
>>
>> tmp/all_interfaces.conf: $(m4support) $(all_interfaces) $(detected_ifs)
>>          @test -d tmp || mkdir -p tmp
>>          $(verbose) m4 $^ | sed -e s/dollarsstar/\$$\*/g > $@
>>
>>
>> you can remove vmware.if you get from trunk or selinux-policy source
>> package, and then build vmware.pp
>>
>>
>>> Thanks in advance.
>>> Louis
>>>
>>>
>>>
>>> --- Ken YANG <spng.yang@gmail.com> wrote:
>>>
>>>> Louis Lam wrote:
>>>>> Hi Ken,
>>>>>
>>>>> Thank you for your replies. I'll try that out.
>>>>>
>>>>> About my system. My target is to use RHEL 5. But i have no restrictions to use FC either.
>>>>>
>>>>> Pardon my ignorance, btw, what do you mean by the "upstream" vmware policy? Where may I be
>>>> able to
>>>>> get it?
>>>> IMHO, "upstream" means reference policy svn trunk, you can get it through:
>>>>
>>>> svn co http://oss.tresys.com/repos/refpolicy/trunk refpolicy
>>>>
>>>> similarly, you can also user vmware[.te, .fc, .if] in EL5 policy source.
>>>>
>>>>
>>>>> Thanks in advance,
>>>>> Louis
>>>>>
>>>>>
>>>>> --- Ken YANG <spng.yang@gmail.com> wrote:
>>>>>
>>>>>> Louis Lam wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> I'm trying to use SELINUX to contain vmware. I'm a newbie to the "newer" modules based
>>>> SELINUX
>>>>>>> under RHEL5/CenTOS5. I can see that there is a vmware.if defined but don't know how to
>> build
>>>>>> the
>>>>>>> module vmware.pp. Not even sure if i'm on the correct track doing this. pl advice.
>>>>>> what is your system? in fedora, there is vmware module at default:
>>>>>>
>>>>>> -(:17:48:$)-> sudo semodule -l|grep vmware
>>>>>> vmware  1.1.1
>>>>>>
>>>>>> if your policy have not vmware module, you can build it from policy source:
>>>>>>
>>>>>> # cd "dir containg your vmware source policy"
>>>>>> (vmware.fc, vmware.te, vmware.if)
>>>>>>
>>>>>> # make -f /usr/share/selinux/devel/Makefile
>>>>>> (you must install selinux-policy-devel package first)
>>>>>>
>>>>>> # semodule -i vmware.pp
>>>>>> # restorecon -R -v "vmware relative directories"
>>>>>>
>>>>>>
>>>>>>> I'm trying to use SELINUX to contain the free vmplayer 2.0.0 downloadable from vmware
>> site.
>>>>>> Has
>>>>>>> anyone succeeded in doing so? Maybe can point me to the right resources. Thanks.
>>>>>> through upstream vmware policy, i can run vmware-workstation 6 smoothly,
>>>>>> so i think vmplayer 2.0.0 is also ok.
>>>>>>
>>>>>>
>>>>>>> Thanks in Advance,
>>>>>>> Louis
>>>>>>>
>>>>>>> Send instant messages to your online friends http://uk.messenger.yahoo.com 
>>>>>>>
>>>>>>> --
>>>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>
>>>>>> --
>>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>
>>>>> Send instant messages to your online friends http://uk.messenger.yahoo.com 
>>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>
>>> Send instant messages to your online friends http://uk.messenger.yahoo.com 
>>>
>>
> 
> 
> Send instant messages to your online friends http://uk.messenger.yahoo.com 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
