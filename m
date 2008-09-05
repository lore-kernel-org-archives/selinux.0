Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m855oc9i014265
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 01:50:38 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m855o0vH006908
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 05:50:00 GMT
Message-ID: <48C0C8A1.2000308@redhat.com>
Date: Fri, 05 Sep 2008 15:50:25 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Targeted Policy" review
References: <48BE3FB4.8020003@redhat.com> <alpine.LRH.1.10.0809032046530.20640@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0809032046530.20640@tundra.namei.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 3 Sep 2008, Murray McAllister wrote:
> 
>> subjects that are not targeted run in the unconfined_t domain type. When a
>> subject runs in the unconfined_t domain type, SELinux rules do not apply, and
>> only DAC rules are used.
> 
> I think we should keep trying to reduce the amount of jargon for users.  
> e.g. can "domain type" be reduced to "domain" or even "label" ?

I changed almost all instances of "domain type" to "domain".


>> 3. As the Linux root user, start the Apache HTTP Server: /sbin/service httpd
>> start. When the server has started, change into a directory where your Linux
>> user has write access to, and run the wget http://localhost/testfile command.
>> Unless there are any changes to the default configuration, this command
>> succeeds.
> 
> I think it would be useful to show the sequence of commands and the 
> output, e.g. what the user would see.

I am adding output for each step.

> 
>> file. Change into a directory where your Linux user has write access to, and
>> run the wget http://localhost/testfile command. Unless there are any changes
>> to the default configuration, this command fails:
>>
>> HTTP request sent, awaiting response... 403 Forbidden
>> 2008-08-22 03:48:40 ERROR 403: Forbidden.
> 
> Perhaps also show the httpd error log entry.
> 

Thanks for the suggestions :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
