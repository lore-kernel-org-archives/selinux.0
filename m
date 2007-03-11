Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2BF0rtC000795
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2007 11:00:54 -0400
Received: from mo11.iijmio.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2BF0oTT008609
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2007 15:00:52 GMT
Date: Mon, 12 Mar 2007 00:00:46 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: Re: [PATCH 0/8] busybox -- SELinux option support for coreutils:
 ver3
Message-Id: <20070312000046.9500d724.himainu-ynakam@miomio.jp>
In-Reply-To: <20070223174733.e67e5fc6.ynakam@hitachisoft.jp>
References: <20070223174733.e67e5fc6.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux support is merged to BusyBox's svn tree for following commands:
cp, mv, install, mkdir, mkfifo,  mknod, stat, ls, id.

runcon and chcon are under review.

We will push more SELinux command to BusyBox's svn tree.

Regards,
Yuichi Nakamura

On Fri, 23 Feb 2007 17:47:33 +0900
Yuichi Nakamura  wrote:

> Hi.
> 
> The following patches provide SELinux options(like -Z) and applets to coreutils.
> To maintain SELinux system, some commands must be extended to be able to handle 
> attribute in SELinux(such as security context).
> 
> Current patch is version 3. 
> We submitted previous patches some weeks ago, and some reviews were done.
> chcon and runcon applets are added, since last patch.
> I think that's all for coreutils.
> 
> We hope the patches are merged into busybox svn tree.
> 
> [1/8] busybox-coreutils-common-01.v3.patch
>  - common component for SELinux options, applets
>    like usage messages, the definition of applets and Kbuild/Config.in.
> 
> [2/8] busybox-coreutils-02-copy.v3.patch
>   - cp: -c option support. 
>       -c option: security context is preserved during file copy.
>   - mv 
>     In SELinux, it is recommended to preserve security context 
>     when file is moved. By this patch, file context is preserved 
>     during file move.
>   - install
>     When file is copied by install, security context of installed file 
>     becomes different from value configured in file_contexts file.
>     By this patch, security context is set according to file_contexts file.
>    -Z option is also supported, security context can be set during file copy.
> (annotation) The reason why the above options are required:
>   SELinux stores secutiry context of files/directories in its
>   xattr area, but most of commands don't pay attention for xattr.
>   Thus, it's not preserved during file copy includes a case when mv
>   falled back into read/write copy.
>   We have to preserve them to keep consistency of the secure system.
> 
> [3/8] busybox-coreutils-03-mk.v3.patch
>  - -Z option support for mkdir, mkfifo, mknod. 
>     By -Z, security context for created file can be set.
>  This improves compatibility with up-streamed coreutils.
> 
> 
> [4/8] busybox-coreutils-04-stat.v3.patch
>  - -Z option support for stat. Security context of file is shown by -Z option.
>  Security context of file is very important attribute for SELinux, 
>  so it should be shown in stat.
> 
> [5/8]  busybox-coreutils-05-ls.v3.patch
>  - -Z option support for ls. Security context of file is shown by -Z option.
>    In current busybox, -k/-K shows security context. However, they are replaced
>  by -Z option in recent coreutils, so -Z have to be added by this patch.
> 
> [6/8] busybox-coreutils-06-id.v3.patch
>  - -Z option support for id. Security context of process is shown by -Z option.
> 
> [7/8] busybox-coreutils-07-chcon.v3.patch
>  - chcon - change security context of file. 
>   chcon provides one of the core facilities to associate a correct security
>   context within files. It enables to change whole or specific parts of the
>   security context within them.
> 
> [8/8] busybox-coreutils-08-runcon.v3.patch
>  - runcon - run application with specified security context.
>   runcon provides one of the core facilities to run application with explicitly
>   specified security context. It enables users to run their application under
>   the least privilege set explicitly.
> 
> 
> This project is originated from some of JPSEUG(Japan SELinux User Group). 
> We have more patches to support SELinux commands/options.
> For list of our work, please visit following site.
> http://code.google.com/p/sebusybox/
> 
> Regards,
> Yuichi Nakamura
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
