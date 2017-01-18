Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0I56eV9009696
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 00:06:41 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so1090706pfu.3
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 21:06:34 -0800 (PST)
Date: Wed, 18 Jan 2017 13:06:29 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Sven Vermeulen <sven.j.vermeulen@gmail.com>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: audit.py required for seobject.py
Message-ID: <20170118050629.GA24957@meriadoc.perfinion.com>
References: <CAPzO=NwAzL1_XDVC3zeR_CH-4khEJs3NnhBYSN1xewMB1DOwOg@mail.gmail.com>
 <1484689831.20454.29.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484689831.20454.29.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 17, 2017 at 04:50:31PM -0500, Stephen Smalley wrote:
> On Sat, 2017-01-14 at 16:33 +0100, Sven Vermeulen wrote:
> > Hi all,
> > 
> > In seobject.py, there are a few calls to
> > audit.audit_encode_nv_string() which seem to make the use of audit.py
> > as offered by the Linux audit daemon's python support mandatory. In
> > the past, the use of this audit module was not mandatory (cfr also
> > seobject.py's wrapped usage of audit in the beginning).
> > 
> > Should we still focus on supporting semanage on systems without Linux
> > audit? If so, do we need to wrap these calls?
> 
> Not unless it presents a real problem for the distros or
> OpenEmbedded...

My preference is more towards removing seobject.py completely. it is
less relevant now that setools4 has most of it. I think i'd rather just
add whatever remaining helpers to setools4 and be done with the clutter.

-- Jason
> 
> > 
> > Wkr,
> >   Sven Vermeulen
> > 
> > PS Sorry for the first incomplete mail submission...
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho
> > .nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
