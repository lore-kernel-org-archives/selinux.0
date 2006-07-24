Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6OJcZvG005106
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 15:38:35 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6OJcYqo000479
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 19:38:34 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <44C51644.3000705@gentoo.org>
References: <44BFECE8.80501@us.ibm.com>	 <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>	 <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>	 <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>	 <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com>	 <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>	 <FA715F0C-F9E5-4F23-807A-A3F97F1402A3@nall.com> <1153765166.6122.107.camel@moss-spartans.epoch.ncsc.mil> <44C51644.3000705@gentoo.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <73CF84C5-8EBA-4F64-8DCC-A852EC33F486@nall.com>
From: Joe Nall <joe@nall.com>
Subject: Re: Existence of "helper" functions (specifcally MLS)
Date: Mon, 24 Jul 2006 14:38:15 -0500
To: SELinux List <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> We have an application that combines data of multiple levels and  
>>> has to
>>> compute the aggregate classification before saving it to a file  
>>> or  sharing
>>> it with another process. Will there be a function to compute an   
>>> aggregate
>>> context from a list of contexts?
>>>
>>
>>
> This sounds like you want to ditch TE altogether and revert to MLS  
> entirely.

Not at all.

Imagine you have a directory with a number of files with
the same type but different classification. A system high
daemon has the task of summarizing a subset of the files
into a report. The system high daemon computes a context
that will allow an unprivileged child process to read all
of the files, launches a child process which then generates
the report. The result being an appropriately classified
report - even if the system high daemon launched the child
process at the wrong level. Throughout the process, type
enforcement is mediating access to system resources.

> That is, it seems like you have to since there is no such thing as  
> an aggregate type. How could we possibly reconcile the user, role  
> and type fields in a list of contexts? This seems like an enormous  
> step backward and makes the application (whatever it is) incapable  
> of using the stronger points of SELinux and from being applied to  
> environments outside of the miltary/government realm.

There may be a type with read access to all of the data.

In the our applications there are two computations that
we perform regularly that may not have clear analogues
in the TE world:

  1) What is the classification of this collection? Often
     recast as 'What clearance must a user have to see
     this collection of data?'

  2) At what classification can these users collaborate?
     Often recast as 'What is the clearance of this group?'

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
