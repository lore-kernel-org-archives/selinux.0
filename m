Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l16L1aH2016053
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 16:01:36 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l16L2hVX008598
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 21:02:43 GMT
Received: by py-out-1112.google.com with SMTP id a78so676pyh
        for <selinux@tycho.nsa.gov>; Tue, 06 Feb 2007 13:02:43 -0800 (PST)
Message-ID: <45C8ED5A.30907@kaigai.gr.jp>
Date: Wed, 07 Feb 2007 06:04:26 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: libselinux utilities applets - please test
References: <200702062029.33013.vda.linux@googlemail.com>
In-Reply-To: <200702062029.33013.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI,

The first serious of SELinux'ed-busybox patches (libselinux utilities)
are merged. It enables the following facilities:

 - When ENABLE_SELINUX=1, '-lselinux -lsepol' was added as a LDFLAGS
 - "Selinux Utilities" group was added onto menuconfig list.
 - 'getenforce' new applet was added.
 - 'getsebool' new applet was added.
 - 'matchpathcon' new applet was added.
 - 'selinuxenabled' new applet was added.
 - 'setenforce' new applet was added.

Now, we are preparing to submit next serious of patches.
see, http://code.google.com/p/sebusybox/

Thanks,

Denis Vlasenko wrote:
> int getsebool_main(int argc, char **argv)
> {
> ...
>         if (!len) {
>                 if (argc < 2)
>                         bb_show_usage();
>                 len = argc - 1;
>                 names = xmalloc(sizeof(char *) * len);
>                 for (i = 0; i < len; i++)
>                         names[i] = xstrdup(argv[i + 1]);
>         }
> 
> Is it necessary to allocate names and xstrdup argv[i]?
> Maybe just do "names = argv + 1"?
> 
> 
> bb_perror_msg_and_die("error while processing %s: ", prefix);
> 
> bb_perror prints: "<applet>: message: <strerror>" - that thrailing
> ": " in your code is not needed.
> 
> 
> +#define matchpathcon_trivial_usage \
> +       "[-n] [-N] [-f file_contexts_file] [-p prefix] [-V]"
> +#define matchpathcon_full_usage \
> +       "\t-n\tDo not display path.\n" \
> +       "\t-N\tDo not use translations.\n" \
> +       "\t-f\tfile_context_file Use alternate file_context file\n" \
> +       "\t-p\tprefix Use prefix to speed translations\n" \
> +       "\t-V\tVerify file context on disk matches defaults"
> 
> Ehhh.... usage.h has such a nice comment at the top:
> 
> /*
>  * This file suffers from chronically incorrect tabification
>  * of messages. Before editing this file:
>  * 1. Switch you editor to 8-space tab mode.
>  * 2. Do not use \t in messages, use real tab character.
>  * 3. Start each source line with message as follows:
>  *    |<7 spaces>"text with tabs"....
>  */
> 
> 
> Okay. I applied your patch to svn and did some changes.
> Please review & test - I can't run-test it at the moment
> (my kernel and userspace is not selinux-enabled).
> 
> Patch is attached for easy review. Thanks.
> --
> vda

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
