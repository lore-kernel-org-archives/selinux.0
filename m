Message-ID: <4B07537B.7070204@tycho.nsa.gov>
Date: Fri, 20 Nov 2009 21:42:03 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Contributed manual pages for libselinux
References: <1257206276.24413.26.camel@tesla.lan>
In-Reply-To: <1257206276.24413.26.camel@tesla.lan>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/02/2009 06:57 PM, Guido Trentalancia wrote:
> Hello !
>
> I found from http://userspace.selinuxproject.org/trac/wiki/Todo that the
> following manual pages were missing for libselinux:
>   

[Added some cc's]

Hi, thanks for doing this.  Some quick review below.


> * matchpathcon_checkmatches
> * matchpathcon_filespec_add
> * matchpathcon_filespec_destroy
> * matchpathcon_filespec_eval
> * matchpathcon_index
> * matchpathcon_init_prefix
>   

There is too much in matchpathcon(3) now.  It's going to need to be
split up into different pages, perhaps the init/fini/teardown stuff in
one page, the lookup calls in another, and the non-matchpathcon prefixed
calls in a third page.

Also, .so manpage links are needed for all the calls here.


> * print_access_vector
>   

Looks good.

> * security_disable
>   

See the selinux.h comments for this.  It needs to be documented that
this function can only be called at startup time.


> * security_set_boolean_list
>   

a RETURN VALUE section is needed in this page, documenting at least this
call if not the others in that page.


> * selinux_check_passwd_access
>   

This is a replacement for the inconsistently named "checkPasswdAccess"
function.  So, the existing description of checkPasswdAccess should be
moved to this function, and checkPasswdAccess should be changed to "this
is a deprecated alias for selinux_check_passwd_access".


> * selinux_init_load_policy
>   

A paragraph break is needed in the DESCRIPTION section before this function.


> * selinux_lsetfilecon_default
>   

See notes above about the matchpathcon manpage.


> * selinux_mkload_policy
>   

Looks good.


> * set_selinuxmnt
>   

This manpage includes two static functions that are not part of the
libselinux API (at least, not anymore) and should be removed.

Also, I'm not comfortable with the description given.  Instead, use the
comments in selinux.h, which are more accurate and verbose.



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
