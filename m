Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PDusSm021590
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 09:56:54 -0400
Received: from ug-out-f131.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PDuZNs011399
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 13:56:36 GMT
Received: by ug-out-f131.google.com with SMTP id 2so18916ugc
        for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 06:56:49 -0700 (PDT)
Message-ID: <59ad41340608250656u613fd90ds5b409e33a6d8565d@mail.gmail.com>
Date: Fri, 25 Aug 2006 15:56:49 +0200
From: "=?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?=" <lorenzohgh@tuxedo-es.org>
Reply-To: lorenzo@tuxedo-es.org
To: "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Subject: Re: [PATCH] add fs_use_xattr on jffs2
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44EEE4DD.5080301@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44EEE4DD.5080301@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey KaiGai,

We talked during the symposium though we didn't have much time for it.
Glad to see you're still working on embedded SELinux stuff. So, what's
the current status of jffs2? It has full support for xattr now, right?
Do the Infradead guys (jffs maintainers) know about this? Or it's
already merged in upstream?

Are you using a special policy?  Busybox modified?

I think this could be a nice thing for the next symposium, say,
prepare modified uClinux buildroot system, make it available so people
can build embedded systems with native support for SELinux. Actually
this will bring some real buzz to the field. There are many platforms
out there supposed to be suitable for building "secure firewall
appliances", yet none implements a single serious solution to make it
"secure" beyond just the buzz wording itself.

Cheers.

PS: Don't hesitate to comment on a private thread. I'm not sure if
someone around will be interested on the idea, thus I'm CC'ing the
list.

On 8/25/06, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> This patch enables to use xattr on jffs2 filesystem.
>
> The jffs2 filesystem is a filesystem for memory technology
> devices (MTD), and xattr supporting on jffs2 is neccesary
> to use SELinux with a small diskless PDA and so on.
> This facility is queued for kernel 2.6.18 now, so I hope
> to merge this small patch into the refpolicy repository.
>
> Example of xattr/jffs2: SELinux on OpenZaurus :D
>   http://www.kaigai.gr.jp/pub/sezaurus.jpg
>
> Thanks,
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>
>
> Index: policy/modules/kernel/filesystem.te
> ===================================================================
> --- policy/modules/kernel/filesystem.te (revision 1965)
> +++ policy/modules/kernel/filesystem.te (working copy)
> @@ -24,6 +24,7 @@
>  fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
>  fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
>  fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
> +fs_use_xattr jffs2 gen_context(system_u:object_r:fs_t,s0);
>  fs_use_xattr jfs gen_context(system_u:object_r:fs_t,s0);
>  fs_use_xattr xfs gen_context(system_u:object_r:fs_t,s0);
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
