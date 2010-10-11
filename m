Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9BI2YtG013815
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2010 14:02:34 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9BI2Xjk022501
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2010 18:02:33 GMT
Received: by pxi15 with SMTP id 15so252591pxi.12
        for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2010 11:02:32 -0700 (PDT)
Message-ID: <4CB3513C.5000603@gmail.com>
Date: Mon, 11 Oct 2010 11:02:36 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Subject: Re: [refpolicy] ERROR 'syntax error' at token ':c' on line 42:
References: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com> <4CB30341.3000200@tresys.com>
In-Reply-To: <4CB30341.3000200@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  On 10/11/2010 05:29 AM, Christopher J. PeBenito wrote:
> On 10/10/10 02:17, Justin Mattock wrote:
>> This is also hitting when building a module for the policy(below)
>> basically start the system(opensuse 11.4) then do:
>>
>> dmesg>  dmesg
>> audit2allow -i dmesg -M Zonemod
>> compilation failed:
>> Zonemod.te:42:ERROR 'syntax error' at token ':c' on line 42:
>> allow auditd_t device_t:chr_file { read write open };
>> #============= auditd_t ==============
>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>> /usr/bin/checkmodule:  loading policy configuration from Zonemod.te
>
> What are the lines above that one that supposedly has an error?
>


the lines above this are:

     class dir { write read search add_name };
}

#============= auditd_t ==============
allow auditd_t device_t:chr_file { read write open };

which seems to be o.k. from over here.

here is dmesg, and some other info:
http://fpaste.org/2ptC/

Justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
