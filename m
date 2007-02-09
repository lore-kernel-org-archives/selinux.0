Date: Fri, 9 Feb 2007 16:44:09 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ynakam@hitachisoft.jp, busybox@busybox.net, selinux@tycho.nsa.gov,
        russell@coker.com.au, rob@landley.net, busybox@kaigai.gr.jp,
        vda.linux@googlemail.com
Subject: Re: [PATCH 0/6] busybox -- SELinux option support for coreutils
Message-Id: <20070209164409.3b302e35.ynakam@hitachisoft.jp>
In-Reply-To: <1170941165.11912.208.camel@moss-spartans.epoch.ncsc.mil>
References: <20070208155417.8d62937f.ynakam@hitachisoft.jp>
	<1170941165.11912.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 08 Feb 2007 08:26:04 -0500
Stephen Smalley wrote:
> On Thu, 2007-02-08 at 15:54 +0900, Yuichi Nakamura wrote:
> > Hi.
> > 
> > The following patches provide SELinux options(like -Z) to coreutils 
> > We imported SELinux options from coreutils 5.97(included in Fedora Core6).
> > You have to enable CONFIG_SELINUX to use following feature.
> > Any of them are fundamental one to use SELinux.
> > We are welcoming any comment, and hope to merge it into busybox.
> 
> I'd suggest looking at the upstream coreutils selinux branch (see Jim
> Meyering's prior announcement of it on selinux list) and make sure you
> are consistent with it rather than Fedora Core 6, as I believe some
> aspects have changed (e.g. cp -a handling).
Thanks for information.
I've looked at upstream coreutils, and found some changes in cp and install.
I will fix them later.

> 
> > 
> > 
> > [1/6] busybox-coreutils-common-01.patch
> >  - usage.h for SELinux options
> > 
> > [2/6] busybox-coreutils-02-copy.patch
> >   - cp: -Z,-c option support. 
> >       -c option: security context is preserved during file copy.
> >       -Z option: security context can be set during file copy.
> >   - mv 
> >     In SELinux, it is recommended to preserve security context 
> >     when file is moved. By this patch, file context is preserved 
> >     during file move.
> >   - install
> >     When file is copied by install, security context of installed file 
> >     becomes different from value configured in file_contexts file.
> >     By this patch, security context is set according to file_contexts file.
> > 
> > [3/6] busybox-coreutils-03-mk.patch
> >  - -Z option support for mkdir, mkfifo, mknod. 
> >     By -Z, security context for created file can be set.
> > 
> > [4/6] busybox-coreutils-04-stat.patch
> >  - -Z option support for stat. Security context of file is shown by -Z option.
> > 
> > [5/6]  busybox-coreutils-05-ls.patch
> >  - -Z option support for ls. Security context of file is shown by -Z option.
> >    In current busybox, -k/-K shows security context. However, they are replaced by -Z option in recent coreutils, so -Z have to be added by this patch.
> > 
> > [6/6] busybox-coreutils-06-id.patch
> >  - -Z option support for id. Security context of process is shown by -Z option.
> > 
> > 
> > This project is originated from some of JPSEUG(Japan SELinux User Group). 
> > Now, we are preparing to submit more patches to support SELinux commands/options.
> > 
> > Regards,
> > 
> > Yuichi Nakamura
> > Hitachi Software
> > SELinux Policy Editor: http://seedit.sourceforge.net/
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> -- 
> Stephen Smalley
> National Security Agency
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
