Message-ID: <461C2A33.6060707@manicmethod.com>
Date: Tue, 10 Apr 2007 20:22:11 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>	 <461A32E0.6020102@manicmethod.com>	 <1176129881.15415.95.camel@moss-spartans.epoch.ncsc.mil>	 <20070410100921.2c4400a6.ynakam@hitachisoft.jp>	 <461BACF8.7000407@manicmethod.com>	 <1176223845.15415.204.camel@moss-spartans.epoch.ncsc.mil>	 <1176233494.15415.213.camel@moss-spartans.epoch.ncsc.mil> <1176234465.32661.1.camel@localhost.localdomain>
In-Reply-To: <1176234465.32661.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-04-10 at 15:31 -0400, Stephen Smalley wrote:
>   
>> On Tue, 2007-04-10 at 12:50 -0400, Stephen Smalley wrote:
>>     
>
>   
>>> Possibly the patch should selectively filter out objects from LOBJS
>>> (i.e. the shared library) while leaving them all in OBJS (i.e. the
>>> static library).  Then you could build a smaller shared libsepol.so
>>> library for installation on the embedded device that would only be used
>>> for e.g. boolean preservation, while still having the full static
>>> libsepol.a library on the build host for compiling checkpolicy and other
>>> users of the static library.  I think they are just trying to allow for
>>> boolean preservation without pulling in all of libsepol.
>>>       
Even given the below fix I like this idea, since the static lib need not 
be present on any production device this should solve the embedded size. 
For example, even on a managed device there may be no need for the 
security server code. One thing that worries me about having so many 
configurations of the library is that when bug reports come in it may be 
difficult to find out how the library was built. Perhaps we should add 
build information into the library that can be printed out with sestatus?

>> Another option would be to "fix" the kernel to preserve booleans
>> atomically across policy reloads.  Which would eliminate the need for
>> sepol_genbools_array altogether at policy load, and solve some other
>> problems, e.g. try running load_policy in a loop and then start another
>> loop that also runs load_policy, and they'll collide pretty fast (one of
>> them will end up trying to read an invalidated /selinux/booleans node
>> from the other's reload).
>>
>>     
>
> I like this idea. Of course, it would mean that permanent boolean
> changes would either require managed policy or a policy recompile, which
> is likely acceptable.
>
>   

I like it too. Permanent boolean changes already require managed policy 
or a policy recompile in trunk (due to removal of setlocaldefs support) 
so there is a good chance that noone will notice :)

Also, AFAIK libselinux only depends on libsepol for the boolean stuff so 
libsepol will no longer be necessary on unmanaged machines with no 
policy compiler, this is good.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
