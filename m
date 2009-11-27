Message-ID: <4B102741.4080507@manicmethod.com>
Date: Fri, 27 Nov 2009 14:23:45 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SELinux@tycho.nsa.gov, ewalsh@tycho.nsa.gov
Subject: Re: Contributed manual pages for libselinux
References: <1257206276.24413.26.camel@tesla.lan>	 <4B07537B.7070204@tycho.nsa.gov> <1258833077.3002.188.camel@tesla.lan>
In-Reply-To: <1258833077.3002.188.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> Hello Eamon !
>
> On Fri, 2009-11-20 at 21:42 -0500, Eamon Walsh wrote:
>
>> Hi, thanks for doing this.  Some quick review below.
<snip>
> Yes, I have now mentioned that checkPasswdAccess is deprecated. We are
> referring to file security_compute_av.3 as the description of these two
> functions lives there...
>
> By the way, it has been pointed out that this function should not
> hard-code a string. I also agree with him, there is a generic constant
> for such "passwd" object class, it is defined in flask.h could be used
> instead of the string, thus avoiding hard-coding and also allowing to
> save a few cycles and be theoretically future-proof (if ever the name
> would change, say to "password", "auth-token" or anything else).
>

You can see here:
http://marc.info/?l=selinux&m=118115728003670&w=2

That the way it is now is quite intentional. For many years we relied on 
the hardcoded offsets in flask.h and it prevented us from removing, or 
reordering object classes. Therefore we now export the values out of the 
kernel in /selinux/class and use those values rather than the ones from 
flask.h (which hopefully could go away some day.)

> --- libselinux/src/checkAccess.c.orig   2009-11-21 20:07:21.000000000
> +0100
> +++ libselinux/src/checkAccess.c        2009-11-21 20:08:36.000000000
> +0100
> @@ -13,17 +13,12 @@ int selinux_check_passwd_access(access_v
>          if (is_selinux_enabled() == 0)
>                  return 0;
>          if (getprevcon_raw(&user_context) == 0) {
> -               security_class_t passwd_class;
>                  struct av_decision avd;
>                  int retval;
>
> -               passwd_class = string_to_security_class("passwd");
> -               if (passwd_class == 0)
> -                       return 0;
> -
>                  retval = security_compute_av_raw(user_context,
>                                                       user_context,
> -                                                    passwd_class,
> +                                                    SECCLASS_PASSWD,
>                                                       requested,
>                                                       &avd);
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
