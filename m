Subject: Re: New rules on restrict kernel module loading
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
Date: Tue, 28 Jun 2016 08:54:34 -0400
MIME-Version: 1.0
In-Reply-To: <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/28/2016 07:02 AM, Dominick Grift wrote:
> On 06/22/2016 09:02 PM, Jeffrey Vander Stoep wrote:
>> selinux@tycho.nsa.gov to bcc
>> 
>> Hi Ravi,
>> 
>> The intent is not to restrict which processes may load modules,
>> but to place restrictions on the origin of the module itself.
>> Modules, like the kernel, should live on a verity protected
>> partition.
>> 
>> If you want system apps to load a kernel module from the system
>> partition you just need to add an allow rule. e.g.
>> 
>> # system_app loads /system/lib/module/wlan.ko allow system_app
>> system_file:system module_load;
>> 
>> Similar rules may be added for platform_app or system_server.
>> 
> 
> In Fedora rawhide i see these where the target is "self". example:
> 
> allow kmod self:system module_load;
> 
> is that intended?

That's the fallback when using init_module() rather than
finit_module() to load modules, since the kernel does not see the file
when using init_module().  With init_module(), userspace loads the
module from the file into memory and passes a (pointer, len) pair to
the kernel; with finit_module(), userspace opens the module file and
passes the open file descriptor to the kernel.  Ideally, one would
convert all users of init_module() to finit_module(), then remove any
self:system module_load permissions and only allow it for specific
file types.
