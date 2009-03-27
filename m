Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RDtaLY013953
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 09:55:36 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RDtZEe002959
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 13:55:36 GMT
Received: by wa-out-1112.google.com with SMTP id m33so590386wag.18
        for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 06:55:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49AEE5EF.6080103@redhat.com>
References: <49AEE5EF.6080103@redhat.com>
Date: Fri, 27 Mar 2009 13:55:33 +0000
Message-ID: <cadfc0e40903270655i27a3d053q96b55a1202878bbe@mail.gmail.com>
Subject: Re: Patch to python bindings
From: Xavier Toth <txtoth@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 4, 2009 at 3:34 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Eliminate lots of avc calls that can not be done in scripting languages.
>
> Throw an exception on error rather then just returning an error code.
>
> setfilecon(x,y) will now throw exeptions.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkmu5e4ACgkQrlYvE4MpobNyBwCg1hmyqzJw7HLf7nV9qokqOmwW
> akwAnjKcWtv3EM84nZgDt6IYN9QQxZa3
> =5lpv
> -----END PGP SIGNATURE-----
>
> --- nsalibselinux/src/selinuxswig.i     2008-08-28 09:34:24.000000000 -0400
> +++ libselinux-2.0.78/src/selinuxswig.i 2009-03-04 15:23:52.000000000 -0500
> @@ -47,8 +47,36 @@
>  %ignore set_matchpathcon_printf;
>  %ignore set_matchpathcon_invalidcon;
>  %ignore set_matchpathcon_canoncon;
> -
> +%ignore set_selinuxmnt;
> +%ignore avc_entry_ref_init;
> +%ignore avc_entry_ref;
> +%ignore avc_memory_callback;
> +%ignore avc_log_callback;
> +%ignore avc_thread_callback;
> +%ignore avc_lock_callback;
> +%ignore avc_cache_stats;
> +%ignore av_decision;
> +%ignore selinux_opt;
> +%ignore selinux_callback;
> +%ignore selinux_get_callback;
> +%ignore selinux_set_callback;
> +%ignore SELboolean;
> +%ignore security_class_mapping;
> +%ignore print_access_vector;
> +%ignore set_matchpathcon_flags;
> +%ignore matchpathcon_fini;
> +%ignore matchpathcon_filespec_destroy;
> +%ignore matchpathcon_filespec_eval;
> +%ignore matchpathcon_checkmatches;
>  %ignore avc_add_callback;
> +%ignore avc_sid_stats;
> +%ignore avc_av_stats;
> +%ignore avc_audit;
> +%ignore avc_destroy;
> +%ignore avc_cleanup;
> +%ignore avc_computer_member;
> +%ignore selinux_set_mapping;
> +%ignore security_id;
>
>  %include "../include/selinux/selinux.h"
>  %include "../include/selinux/avc.h"
> --- nsalibselinux/src/selinuxswig_python.i      2009-01-13 08:45:35.000000000 -0500
> +++ libselinux-2.0.78/src/selinuxswig_python.i  2009-03-04 15:23:52.000000000 -0500
> @@ -150,4 +159,12 @@
>        free($1);
>  }
>
> +%exception {
> +  $action
> +  if (result < 0) {
> +     PyErr_SetFromErrno(PyExc_OSError);
> +     return NULL;
> +  }
> +}
> +
>  %include "selinuxswig.i"
>
>

Could you please rollback this change as we are using av_decision.
> +%ignore av_decision;

For example:
def check_dominance(con):
    (rc, raw_con) = selinux.selinux_trans_to_raw_context(con)
    (rc, dom_context) = selinux.getcon()
    (rc, dom_raw_context) = selinux.selinux_trans_to_raw_context(dom_context)

    avd = selinux.av_decision()
    selinux.avc_reset()
    rc = selinux.security_compute_av_raw(dom_raw_context, raw_con, SECCLASS_CONT
EXT, CONTEXT__CONTAINS, avd)
    if (avd.allowed & CONTEXT__CONTAINS) == CONTEXT__CONTAINS:
        return True
    else:
        return False


Thanks
Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
