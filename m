References: <B566A9B5-2746-4A0F-8E0C-07361FA300CE@gmail.com> <1225998617.814.126.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <C7A6E89D-E668-410D-8536-960255821C3F@gmail.com>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1225998617.814.126.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 5F136)
Subject: Re: Restorecond.conf
Date: Thu, 6 Nov 2008 11:27:43 -0800
Cc: SELinux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Cool,
  anything in the home dir.
Besides that I'm still seeing a fail
During boot. Maybe due to me
Using all of Ubuntu intrepid except
For policycoreutils, which I grabbed
 From Debian sid. Once I get to an Internet connection I'll try and  
downgrade to see if this was the case.

justin P. Mattock



On Nov 6, 2008, at 11:10 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2008-11-06 at 11:03 -0800, Justin P. Mattock wrote:
>> I'm seeing a fail during boot,
>> Not sure if this is restorecond or not.
>> When looking at restorecond.conf
>> /etc/samba/secrets.tdb is at
>> /var/lib/samba/secrets.tdb
>>
>> ~/public_html doesn't exist
>>
>> ~/.mozilla/plugins/libflashplayer.so
>> is at
>> /usr/lib/flashplugin-nonfree/libflashplayer.so
>>
>> Does it hurt to just change the loaction in restorecond.conf or  
>> should
>> I configure these apps to use these files?
>
> If you use restorecond (which is optional), then you would normally
> modify restorecond.conf to match your system, not the other way  
> around.
> And only for files that are likely to get re-created at runtime in a  
> way
> that won't preserve their security contexts already (either by  
> virtue of
> a type transition rule based on creating domain and parent directory
> type or by virtue of explicit application support for preserving
> contexts).
>
> So for example,
> /usr/lib/flashplugin-nonfree/libflashplayer.so
> is likely already labeled correctly at install time based on your
> file_contexts configuration and doesn't require anything in
> restorecond.conf, whereas if you locally install a
> ~/.mozilla/plugins/libflashplayer.so
> it likely wouldn't have the right context by default.
>
> -- 
> Stephen Smalley
> National Security Agency
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
