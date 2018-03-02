Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w22JlY4t032668
 for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2018 14:47:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3ztKZr516YzJnYV
 for <selinux@tycho.nsa.gov>; Fri,  2 Mar 2018 19:47:32 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3ztKZr2RRKzJpBW
 for <selinux@tycho.nsa.gov>; Fri,  2 Mar 2018 19:47:32 +0000 (UTC)
Received: by mail-ot0-f176.google.com with SMTP id y11so9787728otg.0
 for <selinux@tycho.nsa.gov>; Fri, 02 Mar 2018 11:47:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
References: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 2 Mar 2018 11:47:29 -0800
Message-ID: <CAFftDdrDRG9PiXkstvasM_2Pnpf-N0hS1vFsVVcAc-ba2pgaEQ@mail.gmail.com>
To: Chris PeBenito <pebenito@ieee.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: libsepol policycap names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 2, 2018 at 10:49 AM, Chris PeBenito <pebenito@ieee.org> wrote:
> I've been able to make SETools dynamically link to libsepol.  However, one
> challenge is with policycap names.  They're static libsepol, with nothing
> that exports them.  Can we either:
>
> * export the sepol_polcap_getname() function, or
> * move the polcap_names[] in polcaps.c into <sepol/policydb/polcaps.h> ?
>
> Then I can avoid having to manually keep a polcap name list inside SETools.

I would rather export the sepol_polcap_getname() rather than the raw mapping
array.

>
> --
> Chris PeBenito
>
