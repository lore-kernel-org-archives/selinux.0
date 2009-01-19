Message-ID: <4974E82F.2030806@cs.purdue.edu>
Date: Mon, 19 Jan 2009 15:53:03 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: domg472@gmail.com, Cheyenne Solo <ayla.cheyenne@gmail.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Base module, modules.conf
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>	 <1232132620.13917.109.camel@localhost.localdomain>	 <1232133792.8594.4.camel@localhost.localdomain> <1232135544.13917.140.camel@localhost.localdomain>
In-Reply-To: <1232135544.13917.140.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2009-01-16 at 20:23 +0100, Dominick Grift wrote:
>   
>> On Fri, 2009-01-16 at 14:03 -0500, Stephen Smalley wrote:
>>
>>     
>>> You need to first obtain a policy source tree as your starting point.
>>> If you want to minimize your divergence from the distro-shipped policy,
>>> then download the selinux-policy source RPM (.src.rpm) for your distro,
>>> expand it, and then customize as desired and rebuild it (Dan - is there
>>> a recipe documented somewhere for doing that?). 
>>>       
>> I have created a screen cast that focuses on just that. However, the
>> file is 200MB and i do not have the ability to host it.
>>     
>
> I just meant writing down the sequence of commands to set up a buildable
> policy source tree from the .src.rpm.  Screencast seems a bit overkill
> for that - it really ought to just be part of the Fedora SELinux FAQ or
> Guide IMHO.
>
>   

Here's what works for me to tweak the policy on a Fedora 8 system.

Make sure you have the latest policy package (otherwise, you might not 
be able to get it in source version):
   yum update
   yum install selinux-policy-targeted

Figure out the version of the rpm:
   rpm -qa | grep selinux-policy-targeted

Get the corresponding source rpm:
   yumdownloader --source `rpm -qa | grep policy-targeted`

Voila! The source rpm is in your current directory.

 From there on, regular instructions for rebuilding rpms apply. The 
following is a short tutorial.
   http://www.hacktux.com/fedora/source/rpm

HTH,
Jacques

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
