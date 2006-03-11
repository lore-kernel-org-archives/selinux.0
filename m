Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2BEdu9Y005898
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 09:39:56 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2BEcLqf012242
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 14:38:21 GMT
Message-ID: <4412E12D.4090801@redhat.com>
Date: Sat, 11 Mar 2006 09:39:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: We need a tool to extract the file context contents out of a
 policy package.
References: <4412C109.1040906@redhat.com> <4412DA4E.4030706@cornell.edu>
In-Reply-To: <4412DA4E.4030706@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Daniel J Walsh wrote:
>> If we had this we could do something like
>>
>> fixfiles -P mypolicy.pp
>>
>> And it would restorecon over the file context.
> - what if the contexts used are defined in another module that isn't 
> linked yet? 
Then it will not work, but I don't see that as a real problem.
> - what if the contexts are in this module, but it isn't loaded?
Ditto
>
> - what about genhomedircon processing?
>
Perhaps, but usually not necessary.  We could have fixfiles run 
genhomedircon before restoring context.
> Why can't we do this in semanage_commit()?
I think the indeterminate time could be a problem.  semodule -i could 
take a half hour...




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
