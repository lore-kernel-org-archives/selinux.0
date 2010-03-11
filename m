Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2BDWSRb028359
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 08:32:28 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2BDWuYv007753
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 13:32:56 GMT
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2BDWPwP005914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 08:32:26 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2BDWPlK011754
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 08:32:25 -0500
Message-ID: <4B98F0E8.2090107@redhat.com>
Date: Thu, 11 Mar 2010 08:32:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: how to cope with file renames?
References: <20100311081913.GC24034@myhost.felk.cvut.cz>
In-Reply-To: <20100311081913.GC24034@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/11/2010 03:19 AM, Michal Svoboda wrote:
> Hello,
>
> I'm struggling with the problem seemingly as old as filesystems - if you
> rename() a file, it retains all its permissions, incl. the context,
> because its inode stays the same.
>
> My particular problem is moving stuff from /tmp using PHP's
> move_uploaded_file function. I'm aware of the copy/delete workaround,
> but that just isn't the same (performance, atomicity, etc.) Also there
> is the way of post-relabeling the moved file but that requires more
> permissions plus there are no selinux bindings in PHP that i'm aware of.
>
>    
I think this is your best option.  Or write your own version.  Maybe 
open a bugzilla on coreutils asking for
an option to either allow you to state the file context of the 
destination or just do not preserve file context.

> In short, I was wondering if there was a way for a rename()d file to be
> subjected to a type transition as if a new file was created? (I tried a
> type_trans rule but to no avail.) Or any other way to deal with renaming
> files between variously contexted dirs?
>
> Michal Svoboda
>
>    


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
