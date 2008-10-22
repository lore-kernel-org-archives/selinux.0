Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <A69BC137-D93E-495F-80B2-8D636620195A@nall.com>
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com>
	 <1224096411.21012.46.camel@gorn.columbia.tresys.com>
	 <842B0735-FCD6-4BAF-B8D3-A462B1D5C9E4@nall.com>
	 <1224161367.21012.57.camel@gorn.columbia.tresys.com>
	 <B644A871-625C-477E-A9EA-6FF003227C8B@nall.com>
	 <48F754B5.8020302@manicmethod.com> <48FCCBB1.1010004@redhat.com>
	 <9E8A5545-7705-4CD3-9015-30AD17FA0AFE@nall.com>
	 <48FD19BB.1090503@tycho.nsa.gov>
	 <1224684070.29917.13.camel@moss-spartans.epoch.ncsc.mil>
	 <A69BC137-D93E-495F-80B2-8D636620195A@nall.com>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 10:28:43 -0400
Message-Id: <1224685723.29917.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-22 at 09:26 -0500, Joe Nall wrote:
> On Oct 22, 2008, at 9:01 AM, Stephen Smalley wrote:
> 
> >   I did notice however that I could also get it to build w/o
> > changing checkmodule by reversing the order of the interface calls  
> > there
> > - not sure if that workaround is usable in the original case that
> > triggered this bug report.
> 
> 
> Arranging modules in the proper order becomes increasingly difficult  
> as module interaction grows. I finally de-optioned the X policy in  
> fedora since it is in base so get our additions to compile. Patch  
> included for reference.
> 
> Making the compiler gracefully deal with options would really be  
> appreciated. I could see the issue in the compiler code, but the right  
> fix wasn't obvious.

Does the patch I posted fix your problem?

> joe
> 
> diff -up serefpolicy-3.5.10/policy/modules/system/userdomain.if.orig  
> serefpolicy-3.5.10/policy/modules/system/userdomain.if
> --- serefpolicy-3.5.10/policy/modules/system/userdomain.if.orig  
> 2008-10-20 14:14:37.000000000 -0500
> +++ serefpolicy-3.5.10/policy/modules/system/userdomain.if       
> 2008-10-20 14:27:37.000000000 -0500
>   #######################################
> @@ -658,9 +660,7 @@ template(`userdom_common_user_template',
> 
>          userdom_exec_generic_pgms_template($1)
> 
> -       optional_policy(`
> -               userdom_xwindows_client_template($1)
> -       ')
> +       userdom_xwindows_client_template($1)
> 
>          ##############################
>          #
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
