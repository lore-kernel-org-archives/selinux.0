Message-ID: <4B10309C.7040204@manicmethod.com>
Date: Fri, 27 Nov 2009 15:03:40 -0500
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
>
> You are welcome, I suppose it was a boring task for many...
>
> Thanks very much for reviewing the changes. And please accept my
> apologies for not placing "[PATCH]" in the subject of the original post.
> I had just subscribed to the list.
>
> I left you cc address intact here...
>
>> There is too much in matchpathcon(3) now.  It's going to need to be
>> split up into different pages, perhaps the init/fini/teardown stuff in
>> one page, the lookup calls in another, and the non-matchpathcon prefixed
>> calls in a third page.
>>
>> Also, .so manpage links are needed for all the calls here.
>
> Yes, matchpathcon is a mess. Following your guidelines, I have now
> splitted the huge and messy page in several different man pages. It's
> easier to consult and easier to maintain.
>
> The first part (page) is strictly related to _init, its variant
> _init_index, _fini, matchpathcon and its variant matchpathcon_index.
> Nice and concise. References are provided in the "SEE ALSO" section to
> the rest.
>
> The second page describes the auxiliary lookup calls
> (matchpathcon_checkmatches) and the inode associations functions
> (matchpathcon_filespec_{add,destroy,eval}). The reference section points
> to the main matchpathcon page.
>
> A third page has been created for the functions that are used to set the
> flags (set_matchpathcon_flags) or to configure the behaviour of the main
> matchpathcon functions (set_matchpathcon_invalidcon and
> set_matchpathcon_printf).
>
> A fourth and fifth page is devoted to functions that should never had
> ended up in matchpathcon (selinux_file_context_cmp and
> selinux_file_context_verify in one page and selinux_lsetfilecon_default
> in another one): we do not really need to save electrons needed for new
> pages...
>
>>
>>> * print_access_vector
>>>
>> Looks good.
>
> No modifications.
>
>>> * security_disable
>>>
>> See the selinux.h comments for this.  It needs to be documented that
>> this function can only be called at startup time.
>
> Ok. I have stressed that now and also mentioned that after the policy
> has been loaded at startup, then only "setenforce" can be used to alter
> (not disable) the mode of the SELinux kernel code (for example by
> placing it into "permissive" mode).
>
>>> * security_set_boolean_list
>>>
>> a RETURN VALUE section is needed in this page, documenting at least this
>> call if not the others in that page.
>
> I have now added a "RETURN VALUE" section.
>
> Also, to avoid confusion, I have rephrased the word "returns" in
> "provides" when not strictly referring the to the return value of the
> function (take for example security_get_boolean_names(), strictly
> speaking the function returns an integer representing 0=success or
> -1=failure, although from a conceptual point of view it also returns a
> list trough modification of one of its parameters passed by reference).
>
> Usually when an application developer looks at the "RETURN VALUE"
> section it is because he/she has already planned/coded the call to the
> function (and thus also the handling to parameters passed by reference)
> and only needs to check for the function exit status so that it can be
> handled properly at the call point.
>
>>> * selinux_check_passwd_access
>>>
>> This is a replacement for the inconsistently named "checkPasswdAccess"
>> function.  So, the existing description of checkPasswdAccess should be
>> moved to this function, and checkPasswdAccess should be changed to "this
>> is a deprecated alias for selinux_check_passwd_access".
>
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
> Note that the above code, should really live in the application and not
> in the selinux library. It used to be like that, then for some reason it
> has been introduced. Redhat's passwd and cronie are calling the library
> function and thus at the moment they rely on it. But for example,
> util-linux-ng has the code in it and does not call this function, as I
> believe it should be. A very minor issue anyway...
>
>>> * selinux_init_load_policy
>>>
>> A paragraph break is needed in the DESCRIPTION section before this function.
>
> Done. I have also added a note to the already mentioned fact that after
> initial policy load, SELinux cannot be anymore disabled using calls to
> security_disable(3).
>
>>> * selinux_lsetfilecon_default
>>>
>> See notes above about the matchpathcon manpage.
>
> Yes, separate man page now.
>
>>> * selinux_mkload_policy
>>>
>> Looks good.
>
> No modifications.
>
>>> * set_selinuxmnt
>>>
>> This manpage includes two static functions that are not part of the
>> libselinux API (at least, not anymore) and should be removed.
>>
>> Also, I'm not comfortable with the description given.  Instead, use the
>> comments in selinux.h, which are more accurate and verbose.
>>
>
> Please let me know if things are any better now.
>
> I did also provide on the same day a patch for beautifying and improving
> the command-line option parsing of a few utilities (a ticket had been
> created by somebody). That patch provides those improvement according to
> GNU-style parsing of "help" and "version" options (including long-option
> variants). I think it also fixes a couple of typos here and there. Feel
> free to include that patch too if you like it, so that the ticket can be
> closed ! I will attach it again in another separate message: it has been
> slightly modified in order to apply cleanly to the latest git snapshot.
>
> More important, I was also thinking about fingerprinting (and
> subsequently checking) the libraries with some cryptographic hash
> function such as the NIST-recommended SHA2. It is beginning to be done
> for security-related projects like OpenSSL, so I believe it is even more
> essential for SELinux. Ever thought about anything like that ?
>
> Best regards,
>
> Guido

Merged in libselinux 2.0.90

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
