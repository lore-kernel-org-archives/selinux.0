Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uADLK9x4016315
 for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2016 16:20:10 -0500
In-Reply-To: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
References: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Diskless system running SELinux
From: Russell Coker <russell@coker.com.au>
Date: Sat, 12 Nov 2016 13:35:29 +1100
To: Andrew Ruch <adruch2002@gmail.com>, SELinux ML <selinux@tycho.nsa.gov>
Message-ID: <9AEED064-DE74-4BAB-8EC2-3639B4BBCDDF@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Sorry for the late reply, but have you considered iSCSI, NBD, and other similar things?

On 8 January 2016 8:48:21 am AEDT, Andrew Ruch <adruch2002@gmail.com> wrote:
>Hello,
>
>I'm researching deploying a diskless system that would use PXEBoot and
>NFS for it's storage. I believe this capability has been proven and
>have no issues here. The tricky part is this system must also have
>Mandatory Access Control. I thought RHEL 7.2 was the answer due to
>it's support of labeled NFS. However, Red Hat just told me that having
>an SELinux-labeled, remote root partition is unsupported. What wasn't
>clear was if the problem was in RHEL or something upstream.
>
>Does the kernel support a labeled, remote root partition? If so, which
>distributions support this?
>
>
>Thanks,
>Andrew Ruch
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Nexus 6P with K-9 Mail.
