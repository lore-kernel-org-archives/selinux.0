Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t83CHAVh010825
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 08:17:10 -0400
Subject: Re: secilc: in segfault
To: selinux@tycho.nsa.gov
References: <20150903094844.GA18832@x250>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55E83A89.5010208@tycho.nsa.gov>
Date: Thu, 3 Sep 2015 08:18:17 -0400
MIME-Version: 1.0
In-Reply-To: <20150903094844.GA18832@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/03/2015 05:48 AM, Dominick Grift wrote:
> Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
>
> $ secilc test/in_test.cil
> Segmentation fault (core dumped)
>
>

It works for me for the current master branch of SELinux userspace installed 
locally. What version are you using?

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
