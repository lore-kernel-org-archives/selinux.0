Message-ID: <43BA6253.6070608@cornell.edu>
Date: Tue, 03 Jan 2006 06:38:59 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] File contexts APIs (part2)
References: <43BA6197.3050402@cornell.edu>
In-Reply-To: <43BA6197.3050402@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh, note that it shouldn't be very hard to add another dbase for 
pre-expansion contexts, and then merge .local into that instead. That 
would give us the capability of writing templated code in 
file_contexts.local, which we currently don't have (right?).

Then again, maybe we should fix templates first before doing that :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
