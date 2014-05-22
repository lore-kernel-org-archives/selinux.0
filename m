Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4M6vlhd018559
 for <selinux@tycho.nsa.gov>; Thu, 22 May 2014 02:57:47 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so2216862pbc.14
 for <selinux@tycho.nsa.gov>; Wed, 21 May 2014 23:57:47 -0700 (PDT)
Received: from [192.168.1.2] ([117.214.175.86])
 by mx.google.com with ESMTPSA id pl10sm11361040pbb.56.2014.05.21.23.57.45
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 21 May 2014 23:57:46 -0700 (PDT)
Message-ID: <537D9F47.7020704@gmail.com>
Date: Thu, 22 May 2014 12:25:03 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Significance of SELinux user and roles on objects.
References: <537AE191.7070403@gmail.com> <537B5BD3.4090507@tresys.com>
In-Reply-To: <537B5BD3.4090507@tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/14 19:12, Christopher J. PeBenito wrote:
> The kernel will create files with object_r regardless

Is this defined in the policy or is hard coded in the kernel?

If it's defined in the policy, can't the role on a newly created file be 
defined such that it's value depends on the SELinux user creating the file?
