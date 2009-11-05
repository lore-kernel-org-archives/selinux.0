Message-ID: <4AF21A47.4000303@ak.jp.nec.com>
Date: Thu, 05 Nov 2009 09:20:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: selinux_check_passwd_access() behaviour when passwd class does
 not exist
References: <1257201838.24413.20.camel@tesla.lan>	 <4AF02C79.30806@redhat.com> <1257280144.3005.86.camel@tesla.lan>
In-Reply-To: <1257280144.3005.86.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> On Tue, 03/11/2009 08.13 -0500, Daniel J Walsh wrote:
> 
>> I am not sure,  I think it could be argued that this function should not be in libselinux at all, since it hard codes policy into the library.
>>
>> I think you need to start setting the errno if you are going to change the function ENOSUPP for this error versus EPERM for the other error, and then all users (passwd?) of the function need to change to look at the errno.
>>
> 
> Or if the intent is just to remove the hard-coded word "passwd" from the
> libselinux code, then it is possible to use SECCLASS_PASSWD defined in
> flask.h as follows:

It goes against the times.

The string_to_security_class(3) enables applications to perform correctly
independent from the security policy.
In principle, user can provide its own security policy with its own set
of object classes and permissions. It can have its own code, and it may
not equivalent to SECCLASS_PASSWD.

My suggestion is to apply security_deny_unknown(3) which returns a preferable
behavior when application requires undefined object classes/permissions.

Thanks,

> --- libselinux/src/checkAccess.c.orig   2009-11-03 21:11:21.000000000
> +0100
> +++ libselinux/src/checkAccess.c        2009-11-03 21:13:44.000000000
> +0100
> @@ -17,13 +17,9 @@ int selinux_check_passwd_access(access_v
>                 struct av_decision avd;
>                 int retval;
>  
> -               passwd_class = string_to_security_class("passwd");
> -               if (passwd_class == 0)
> -                       return 0;
> -
>                 retval = security_compute_av_raw(user_context,
>                                                      user_context,
> -                                                    passwd_class,
> +                                                    SECCLASS_PASSWD,
>                                                      requested,
>                                                      &avd);
> 
> This solution shortens the code and also avoids the issue that might
> arise if such a security object class is not defined, because the
> library simply won't compile...
> 
> Guido
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
