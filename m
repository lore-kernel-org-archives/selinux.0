Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8EDXvFI024448
 for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2015 09:33:57 -0400
Subject: Re: secilc: segfault on what should be "Recursive block call found"?
To: <selinux@tycho.nsa.gov>
References: <20150912125321.GB4006@x250> <20150914132404.GA15129@x250>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <55F6CCAB.6030105@tresys.com>
Date: Mon, 14 Sep 2015 09:33:31 -0400
MIME-Version: 1.0
In-Reply-To: <20150914132404.GA15129@x250>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/14/2015 09:24 AM, Dominick Grift wrote:
> On Sat, Sep 12, 2015 at 02:53:21PM +0200, Dominick Grift wrote:
> <snip>
> 
>> secilc helpfully threw a message telling me:
> 
>>     Recursive macro call found
>>     Failed to compile cildb: -1
> 
> 
> The above is an example for how error message should *not* look. Here is
> an example of how they *should* look:
> 
> macro statement is not allowed in optionals (/run/user/1000/dssp/sources/modules/contrib/system/usersubj/macros.cil:819)
> 


The original issue was with recursive blockinherits. Should have a patch
out shortly. Will also improve the error message for macros (and
blockinherits) to show a trace of where the recursion came form.

- Steve
