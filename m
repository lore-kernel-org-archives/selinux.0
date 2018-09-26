Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QB6HZV012079
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 07:06:17 -0400
Received: by mail-lj1-f180.google.com with SMTP id f8-v6so24808055ljk.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 04:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhFHN8TfDUC8CP=bMiKx0BVNNZuzKcCNPC6hVawMyjBAz1x3Q@mail.gmail.com>
 <CAPhFHN_tOXnaU7EGZ9o_ht4XGqqsAS-VmauH5o7Cb71KF3eN3w@mail.gmail.com>
 <20180925134617.GA27672@julius.enp8s0.d30>
In-Reply-To: <20180925134617.GA27672@julius.enp8s0.d30>
From: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Date: Wed, 26 Sep 2018 20:05:31 +0900
Message-ID: <CAPhFHN9odTm8v2yRkC0osQNSO0STn5JYbGf=xupFSBT_HX-uvw@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: autorelabel loops in system executed 'semodule -d
 unconfined'
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello, Dominick.

I could relabel the system in permissive mode.

Thank you.

2018年9月25日(火) 22:46 Dominick Grift <dac.override@gmail.com>:
>
> On Tue, Sep 25, 2018 at 07:19:23AM +0900, Shintaro Fujiwara wrote:
> > Hi, SELinux.
> >
> > I captured a picture saying this.
> >
> > rm: cannot remove '/.autorelabel' : Permission denied
> >
> > /.autorelabel could not be removed, so going into the loop, I guess.
> >
> > How can I autorelabel properly even if I delete unconfined module?
>
> This may or may not be a policy issue (see avc denials), but:
>
> Generally you want to do a full relabel in permissive mode.
>
> >
> > Thanks.
> > 2018年9月25日(火) 6:55 Shintaro Fujiwara <shintaro.fujiwara@gmail.com>:
> > >
> > > Hello, SELinux.
> > >
> > > I was playing with my F28 latest with 'semodle -d unconfined'.
> > > I executed this and relabeling starts even after finished relebeling
> > > and looks like going into the loop.
> > > # touch /.autorelabel
> > > # shtudown -r now
> > >
> > > I have attached a picure.
> > >
> > > Thanks.
> >
> >
> >
> > --
> > Help analyzing sar file
> > https://github.com/intrajp/sar-analyzer
> >
> > LFS Scripts will make Linux From Scratch easy
> > https://github.com/intrajp/LFS-scripts-systemd
> >
> > SHIRASAGI-hardening Project
> > https://github.com/intrajp/shirasagi-hardening
> >
> > Linux Distribution Project
> > http://sourceforge.net/projects/pinkrabbitlinux/
> >
> > Introducing hardrock and heavymetal
> > http://heavymetalhardrock.no-ip.info/
> >
> > Open Source Software to manage SELinux at ease
> > http://sourceforge.net/projects/segatex/
> >
> > Help SELinux administration
> > https://github.com/intrajp/segatex-ng
> >
> > network-magic ( Useful tool for network-administrators )
> > https://github.com/intrajp/network-magic
> >
> > CMS（with PHP & PostgreSQL）
> > http://sourceforge.net/projects/webon/
> > https://github.com/intrajp/irforum_jp
>
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
