Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7GB97vp027878
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 07:09:07 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so136969615wma.1
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 04:09:06 -0700 (PDT)
Received: from ?IPv6:2a02:8428:4da:9800:d18e:4cd5:a616:57e8?
 (2a02-8428-04da-9800-d18e-4cd5-a616-57e8.rev.sfr.net.
 [2a02:8428:4da:9800:d18e:4cd5:a616:57e8])
 by smtp.googlemail.com with ESMTPSA id us9sm26116861wjb.43.2016.08.16.04.09.03
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Aug 2016 04:09:03 -0700 (PDT)
Subject: Re: libselinux Python wrapper and SWIG 3.0.10
To: selinux@tycho.nsa.gov
References: <a87a04a3-f175-0869-ac5e-654ac9206f5e@m4x.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <f3457099-10fb-71b3-590c-133e68b412ea@m4x.org>
Date: Tue, 16 Aug 2016 13:09:03 +0200
MIME-Version: 1.0
In-Reply-To: <a87a04a3-f175-0869-ac5e-654ac9206f5e@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 16/08/16 12:57, Nicolas Iooss wrote:
> Hello all,
> 
> The last SWIG release (3.0.10, release in June) introduced an
> incompatibility in the way the Python wrapper loads its C module, as
> described in SWIG ChangeLog [1]. This breaks "import selinux" on systems
> running Arch Linux

While looking at the git log I just saw
https://github.com/SELinuxProject/selinux/commit/a9604c30a5e2f71007d31aa6ba41cf7b95d94822
which seems to solve this issue. I'll backport this commit.

Sorry for the noise,
Nicolas
