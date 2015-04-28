Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3SHJJv7021926
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 13:19:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SHJOOf029117
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 13:19:24 -0400
Message-ID: <553FC119.50402@redhat.com>
Date: Tue, 28 Apr 2015 19:19:21 +0200
From: Florian Weimer <fweimer@redhat.com>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
 SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com> <552FFA39.3030909@redhat.com>
 <553507A0.1050902@redhat.com> <553FBF96.8030309@redhat.com>
In-Reply-To: <553FBF96.8030309@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2015 07:12 PM, Miroslav Grepl wrote:

>> <https://github.com/abrt/abrt/commit/3e4155bfcd9f6f5a20964080fa05724503b20761>
> 
> I would go with _raw interfaces how Stephen suggested above.

Thanks.

I think the current version is here:

<https://github.com/abrt/abrt/commit/c4f06d4198658c82550e93bb2617b96022c06cf4>

> Also we should take care about ABRT SELinux policy.

See <https://bugzilla.redhat.com/show_bug.cgi?id=1212885>.  As far as I
understand it, with the current default behavior, an effective SELinux
policy is difficult to write.

-- 
Florian Weimer / Red Hat Product Security
