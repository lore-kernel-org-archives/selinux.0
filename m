Message-ID: <4365DA59.7030609@cornell.edu>
Date: Mon, 31 Oct 2005 03:48:25 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE 3 ] Common database code
References: <4365D935.1070601@cornell.edu>
In-Reply-To: <4365D935.1070601@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> - this still doesn't let me call other database functions from an 
> iterate() handler, but I think it might get us closer to this goal.
>
I mean outside a transaction...inside a transaction this will work just 
fine as is..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
