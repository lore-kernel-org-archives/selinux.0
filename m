Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0GNrnoE016113
 for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2018 18:53:49 -0500
Received: by mail-qk0-f182.google.com with SMTP id l64so23061261qke.13
 for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2018 15:53:43 -0800 (PST)
To: Stephen Smalley <sds@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>,
 SELinux <selinux@tycho.nsa.gov>
References: <0d560876-f29f-1da8-7c30-459abcb4e1a9@ieee.org>
 <1516118572.10453.11.camel@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <0d7f0979-b793-4fd5-f01a-6aca189f3144@ieee.org>
Date: Tue, 16 Jan 2018 18:53:42 -0500
MIME-Version: 1.0
In-Reply-To: <1516118572.10453.11.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: ANN: Reference Policy 2.20180114
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/16/2018 11:02 AM, Stephen Smalley wrote:
> On Sun, 2018-01-14 at 15:02 -0500, Chris PeBenito via refpolicy wrote:
>> A new release, 2.20180114, of the SELinux Reference Policy is now
>> available on the GitHub site:
>>
>> https://github.com/TresysTechnology/refpolicy/wiki/DownloadRelease
> 
> Could we get the nnp_nosuid_transition policy capability enabled in the
> next release?

That's my mistake; I should have enabled it in this release.  Enabled in 
master now.

-- 
Chris PeBenito
