Message-ID: <43454B30.2040005@cornell.edu>
Date: Thu, 06 Oct 2005 12:05:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>
In-Reply-To: <43454A61.8010907@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The purpose of this patch is to resync against what I have here,
The next patch will focus on:

- adding a new debug system to semanage
- testing and debugging the file database code path
- some commit() integration (I want changes and saving to files to work 
perfectly - then I'll worry about the policy).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
