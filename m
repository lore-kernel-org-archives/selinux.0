Message-ID: <49DE2AA9.3010608@kutulu.org>
Date: Thu, 09 Apr 2009 13:04:41 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Problems related to the policy language
References: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On the subject of language inconsistencies:

One thing that I frequently find myself doing wrong is nesting the 
various types of blocks.  IIRC, you can nest a tunable policy inside an 
optional block, but not vice versa.  I understand why -- one is resolved 
at policy compile time and the other at run time -- but just from a 
policy language perspective it seems inconsistent.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
