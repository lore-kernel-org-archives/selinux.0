Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u07MM1DK016673
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 17:22:01 -0500
Subject: Re: Diskless system running SELinux
To: Andrew Ruch <adruch2002@gmail.com>, SELinux ML <selinux@tycho.nsa.gov>
References: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <568EE4E6.6090907@redhat.com>
Date: Thu, 7 Jan 2016 17:21:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 01/07/2016 04:48 PM, Andrew Ruch wrote:
> Hello,
>
> I'm researching deploying a diskless system that would use PXEBoot and
> NFS for it's storage. I believe this capability has been proven and
> have no issues here. The tricky part is this system must also have
> Mandatory Access Control. I thought RHEL 7.2 was the answer due to
> it's support of labeled NFS. However, Red Hat just told me that having
> an SELinux-labeled, remote root partition is unsupported. What wasn't
> clear was if the problem was in RHEL or something upstream.
>
> Does the kernel support a labeled, remote root partition? If so, which
> distributions support this?
>
>
> Thanks,
> Andrew Ruch
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
I just think no one has ever tried this.  If the remote system is setup
with nfs labeling, theoretically this
should work.

Not only rhel7 supports labeled networking on the server and client, to
the best of my knowleged.

Not sure if NetApp or EMC support it yet.
