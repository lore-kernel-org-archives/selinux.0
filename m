Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7IFFRSE030821
 for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2015 11:15:29 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 6FD2E19F39B
 for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2015 15:15:26 +0000 (UTC)
Subject: Re: auditing kdbus service names
To: selinux@tycho.nsa.gov, "pmo >> Paul Moore" <pmoore@redhat.com>
References: <3754565.WlII3JJvve@sifl>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <55D34C0C.3000600@redhat.com>
Date: Tue, 18 Aug 2015 17:15:24 +0200
MIME-Version: 1.0
In-Reply-To: <3754565.WlII3JJvve@sifl>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2015 02:40 PM, Paul Moore wrote:
> Hello all,
> 
> I'm currently working on a set of LSM hooks for the new kdbus IPC mechanism 
> and one of the things that I believe we will need to add is a new audit field 
> for the kdbus service name (very similar to the old fashioned dbus service 
> name).  I was thinking "kdbus_svc" for the field name, any objections?
> 
Paul,
really great news.

Thx.

-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
