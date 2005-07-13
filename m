Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6DEisgA025446
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 10:44:54 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6DEeuZr012584
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 14:40:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6DEfeTd002845
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 10:41:41 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6DEfeV16770
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 10:41:40 -0400
Received: from [172.16.50.27] (vpn50-27.rdu.redhat.com [172.16.50.27])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6DEfdg1008067
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 10:41:40 -0400
Message-ID: <42D52837.9050206@redhat.com>
Date: Wed, 13 Jul 2005 10:41:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: MCS/Targeted Policy...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We at Red Hat are working on a new type of Policy called MCS.  (Multiple 
Category Security)

A quick overview from James Morris..

>It's essentially a scheme where we take MLS and:
> - Ignore sensitivity levels
> - Allow users discretionary control over categories
> - Remove BLP constraints
>
>This is intended as a user-oriented extension to SELinux where DAC and TE 
>are able to be further restricted by user assigned categories of the 
>user's choosing e.g. "Company Confidential" or "Salary Information"
>
>Part of the idea is to make more general use of the MLS infrastructure and 
>to try and enhance community traction.
>
We will describe it more in the future. 

We would like to role this out in FC5, along with some other changes.  
The biggest problem with it is upgrade.
We are turning on the fourth field (MLS) field of the security context, 
but files on disk don't have this field now.
So we want to avoid a complete relabel, on upgrade.  We would like to 
have the kernel default all files to an MLS
field of s0.  Some discussion of this has happened offline. And we are 
looking for a way to do this without adding
a new field/type to the policy and requiring we rev the policy version.  
One suggestion is that the kernel use the
initial_sids_file, and the "sid file" record.

sid file        system_u:object_r:file_t:s0

The kernel could use this to default any missing field to the value from 
this record.

- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
