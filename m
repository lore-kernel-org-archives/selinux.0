Message-ID: <418961EE.4070008@redhat.com>
Date: Wed, 03 Nov 2004 17:55:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: What policy is the system running?
References: <20041103185116.24681.qmail@web50606.mail.yahoo.com>
In-Reply-To: <20041103185116.24681.qmail@web50606.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James suggests that we have a table on disk that references the checksum 
to a name.

So we could get the checksum from the kernel and then look up the name 
to display
to the user.  Could have Makefile and rpm update the policy whenever it 
is modified.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
