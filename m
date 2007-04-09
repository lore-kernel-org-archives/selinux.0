Message-ID: <461A32E0.6020102@manicmethod.com>
Date: Mon, 09 Apr 2007 08:34:40 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, busybox@kaigai.gr.jp
Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
In-Reply-To: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:
> <snip>
In the future could you please inline the patch?
> 2. About patch
> We prepare 2 build options in libselinux/libsepol.
> 1) make EMBEDDED=1
> This is for people who want to use only monolitic policy with boolean support.
> * libselinux
>   Files related to userland avc is not compiled
> * libsepol
>   libselinux uses sepol functions(such as sepol_genusers, sepol_genboolean). 
>   If people do not need modular policy, we need only to compile such functions.
>
> 2) make DISABLE_SEPOL=1
> This can be combined with "EMBEDDED=1".
> This is for people who uses poor resource devices.
> libsepol functions are removed from libselinux 
> so libsepol can be removed.
> By that, size of libse*  can be reduced more, 
> but some features(such as boolean) can not be used.
>
>   
I think the defines should be more descriptive, perhaps NO_AVC, NO_BOOL, 
etc.

Is there ever a reason to use DISABLE_SEPOL without EMBEDDED? it seems 
like you leave the option open but never describe why it would be used 
or what the side effects would be.

> More detail:
> * libselinux 
>   - selinux_mk_loadpolicy is replaced with limited version:
>      - policy filename is assumed as /etc/selinux/<policy type>/policy/policy.<version in selinuxfs>
>   
This won't reduce the code much, is there a reason that you don't try to 
search for the policy file at all? Granted this shouldn't be an issue in 
embedded environments since you should have control of the kernel and 
policy at all times but it could be useful to load a policy of differing 
version than the kernel supports.

OTOH this could be a good time to get rid of the .version convention 
anyway, there is little reason for it anymore and it causes stale 
policies to be left around when libsepol is upgraded.
>      - preserve boolean is not supported
>          -- so it is not recommended to use boolean for such system
>      - system.users, local.users are not supported
>    - -lsepol is removed
> * libsepol
>   - It is not required by libselinux, so you do not have to compile this.
>
> 3. Size measurement
> Compiled by gcc(x86)
>
> * Before:
> libselinux.so.1: 115420
> libsepol.so.1:302085
> Total: 417505
>
> * make EMBEDDED=1
> libselinux:87024
> libsepol:201301
> Total: 288325
>
> * make EMBEDDED=1 DISABLE_BOOLEAN=1
> libselinux: 77187
> libsepol: 0 
> Total: 77187 -> Diet about 80%!
>
> And, this work is intended to be applied to BusyBox.
> We will fix load_policy applet for BusyBox to support boolean option.
>
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
