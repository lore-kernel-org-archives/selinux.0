Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IL23Vm008538
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:02:03 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IL22OP027259
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 21:02:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL22iM025308
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:02:02 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL22fv002885
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:02:02 -0400
Received: from [10.11.14.21] (vpn-14-21.rdu.redhat.com [10.11.14.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL21F0028278
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:02:01 -0400
Subject: Re: [PATCH - policyrep] Add generic iterators and a linked-list
	data structure to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1176929134.11469.43.camel@localhost.localdomain>
References: <1176929134.11469.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 16:58:39 -0400
Message-Id: <1176929919.11469.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-18 at 16:45 -0400, Karl MacMillan wrote:
> Add a generic iterator data structure and a linked-list implementation
> based that uses the iterators to libsepol. Includes test cases for the
> linked-list implementation.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 

Actually - this patch is missing extern on most of the function
definitions. Updated patch coming.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
