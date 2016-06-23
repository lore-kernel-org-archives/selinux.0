Subject: Re: New rules on restrict kernel module loading
To: Jeffrey Vander Stoep <jeffv@google.com>, Ravi Kumar <nxp.ravi@gmail.com>,
 seandroid-list@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
Cc: SELinux <Selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <395eab36-6606-ff45-ee57-959538a58d65@tycho.nsa.gov>
Date: Thu, 23 Jun 2016 13:23:21 -0400
MIME-Version: 1.0
In-Reply-To: <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2016 03:02 PM, Jeffrey Vander Stoep wrote:
> selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov> to bcc
> 
> Hi Ravi,
> 
> The intent is not to restrict which processes may load modules, but to
> place restrictions on the origin of the module itself. Modules, like the
> kernel, should live on a verity protected partition.
> 
> If you want system apps to load a kernel module from the system
> partition you just need to add an allow rule. e.g.
> 
> # system_app loads /system/lib/module/wlan.ko
> allow system_app system_file:system module_load;
> 
> Similar rules may be added for platform_app or system_server. 

Actually, that probably won't work for any app domains, as they can't
pass the sys_module capability check.  So hopefully you only truly need
it for system_server.
