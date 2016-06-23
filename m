Subject: Re: New rules on restrict kernel module loading
To: Ravi Kumar <nxp.ravi@gmail.com>, Jeffrey Vander Stoep <jeffv@google.com>
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <CACikiw0XhrE5+2R-AKHztPjtrAyUUq=uGG28A4vb-E+LYtY_og@mail.gmail.com>
Cc: seandroid-list@tycho.nsa.gov, SELinux <Selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d23e0ebd-866e-af74-209b-21f0b9d68bec@tycho.nsa.gov>
Date: Thu, 23 Jun 2016 13:20:00 -0400
MIME-Version: 1.0
In-Reply-To: <CACikiw0XhrE5+2R-AKHztPjtrAyUUq=uGG28A4vb-E+LYtY_og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/23/2016 01:01 PM, Ravi Kumar wrote:
> Hi Jeffrey,
> I tried to do the same , 
> added the allow rule in system_server as 
> / allow system_server system_file:system module_load;/
> 
> But still seeing issue  as of the wlan.ko is a symlink as below  
> wlan.ko -> /system/lib/modules/vendor_wlan.ko 
> 
> Wlan.ko   or  vendor_wlan.ko are with   u:object_r:system_file:s0
> 
> But still  i see there is some issue where it show up this denial .
> 
> W WifiStateMachin: type=1400 audit(0.0:2074): avc: denied { module_load
> } for scontext=u:r:system_server:s0 tcontext=u:r:system_server:s0
> tclass=system permissive=0
> in the above denial  i see the tcontext as system_server.
> 
> I had not debugged much into will do  but looks like there is some thing
> which we are missing . 

hardware/libhardware_legacy/wifi/wifi.c needs to be updated to use
open() + finit_module() rather than load_file() + init_module().

And bionic needs to export finit_module?
