Message-ID: <4D8BB5C5.2060609@gmail.com>
Date: Thu, 24 Mar 2011 14:21:09 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: RIP: 0010:[<ffffffff811bdec1>] [<ffffffff811bdec1>] avc_audit_post_callback+0xc6/0xfe
References: <AANLkTi=UYvBV9piRpUapcf+6gFyJpOg8yAxt0NG9J_Re@mail.gmail.com>	 <1298642860.13368.15.camel@moss-pluto>	 <01F4E579-2929-4CB0-B994-1C325DE9E6F7@gmail.com> <1300975264.8157.40.camel@moss-pluto>
In-Reply-To: <1300975264.8157.40.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/24/2011 07:01 AM, Stephen Smalley wrote:
> On Fri, 2011-02-25 at 09:18 -0800, Justin Mattock wrote:
>> On Feb 25, 2011, at 6:07 AM, Stephen Smalley wrote:
>>
>>> On Thu, 2011-02-24 at 12:57 -0800, Justin Mattock wrote:
>>>> this just popped up..:
>>>>
>>>>
>>>> [29804.908327] SELinux:  Invalid class 3588
>>>> [29804.908438] ------------[ cut here ]------------
>>>> [29804.908443] kernel BUG at security/selinux/avc.c:162!
>>>
>>> It might help debugging to get as much of the AVC message as we can
>>> even
>>> in this case, e.g.
>>
>> cool, thanks for the debug patch... I applied it, and will run it to
>> see if this fires off..
>> current kernel is: 2.6.38-rc6-00116-g2821f46
>
> Did you ever get any output from this debug patch?  It would have shown
> up as an AVC message with tclass=[0-9]* rather than a class name.
>

I'm looking and havent found the debug avc messge just yet, but I did 
apply this patch on top of the current Mainline:
full dmesg for you(Thanks to fedora for providing the fpaste site!!)

http://fpaste.org/U6H3/

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
