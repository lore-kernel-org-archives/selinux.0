Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5TBJXiK006549
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 07:19:33 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 1CE5ABC8DD
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (dhcp-10-40-2-107.brq.redhat.com
 [10.40.2.107])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t5TBJTmZ020020
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 07:19:30 -0400
Message-ID: <559129C1.4010201@redhat.com>
Date: Mon, 29 Jun 2015 13:19:29 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: type inheritance in CIL
References: <5590F3DE.8070202@redhat.com> <20150629075651.GA8191@x250>
In-Reply-To: <20150629075651.GA8191@x250>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/29/2015 09:56 AM, Dominick Grift wrote:
> On Mon, Jun 29, 2015 at 09:29:34AM +0200, Miroslav Grepl wrote:
>> Trying to make sandbox working using CIL but I see it does not
>> support typeinherit statement.
> 
> One of those features that really define CIL but that is currently
> not available or fully working yet.
> 
> My suggestion is to study the "cilpolicy" (which is really just a
> snapshot of reference policy transformed to cil with hll i
> believe)
> 
> This will give you some pointers as to how to create an alternative
> implementation that achieves a similar result.
> 
> When you write CIL policy, there are some "bugs" to take into
> account and to workaround.
> 

Sure there are different ways how to write it. I just wanted to
combine it with the current Fedora policy as much as possible without
re-writing the current Fedora policy.

>> 
>> -- Miroslav Grepl Senior Software Engineer, SELinux Solutions Red
>> Hat, Inc. _______________________________________________ Selinux
>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>> containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> 
> _______________________________________________ Selinux mailing
> list Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
