Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6160Z0k007944
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 02:00:43 -0400
Received: from mail-px0-f197.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6161AdA016183
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 06:01:10 GMT
Received: by pxi35 with SMTP id 35so553687pxi.32
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 23:00:34 -0700 (PDT)
Message-ID: <4A4AFBC5.2010905@gmail.com>
Date: Tue, 30 Jun 2009 23:01:41 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: RBAC with SELinux MCS
References: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
In-Reply-To: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shaz wrote:
> Dear list,
>
> I was studying some earlier work on RBAC and came across Kuhn98 [1], 
> which says that RBAC can be implemented if some interface function is 
> used to map privilege sets of RBAC with MCS. James Moris blog article 
> on MCS [2] states that MCS is just dicretionary like DAC if 
> hierarchies like of MLS levels are not used. It might be because of 
> the implementation of current LSPP on Linux distros. So my question is 
> that can RBAC be used with SELinux if the mapping function is provided?
>
> Some further literature or existing work being pointed out will be 
> appreciated.
>
> Thank you.
>
> [1] 
> http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
> [2] http://james-morris.livejournal.com/5583.html
>
> -- 
> Shaz
>
Im guessing the mapping function is "newrole" right!
if then yeah you should be able too i.g.
newrole -r  *_r -- -c /usr/bin/* (or wherever/whatever your
wanting to use in that role).
might get complicated with the sensitivity
levels and categories(that is if you really tweak them).

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
