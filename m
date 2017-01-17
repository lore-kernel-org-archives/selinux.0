Message-ID: <1484689831.20454.29.camel@tycho.nsa.gov>
Subject: Re: audit.py required for seobject.py
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sven Vermeulen <sven.j.vermeulen@gmail.com>, SELinux
 <selinux@tycho.nsa.gov>
Date: Tue, 17 Jan 2017 16:50:31 -0500
In-Reply-To: <CAPzO=NwAzL1_XDVC3zeR_CH-4khEJs3NnhBYSN1xewMB1DOwOg@mail.gmail.com>
References: <CAPzO=NwAzL1_XDVC3zeR_CH-4khEJs3NnhBYSN1xewMB1DOwOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-01-14 at 16:33 +0100, Sven Vermeulen wrote:
> Hi all,
> 
> In seobject.py, there are a few calls to
> audit.audit_encode_nv_string() which seem to make the use of audit.py
> as offered by the Linux audit daemon's python support mandatory. In
> the past, the use of this audit module was not mandatory (cfr also
> seobject.py's wrapped usage of audit in the beginning).
> 
> Should we still focus on supporting semanage on systems without Linux
> audit? If so, do we need to wrap these calls?

Not unless it presents a real problem for the distros or
OpenEmbedded...

> 
> Wkr,
>   Sven Vermeulen
> 
> PS Sorry for the first incomplete mail submission...
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
