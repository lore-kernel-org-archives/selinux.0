Message-ID: <436946FB.8060802@cornell.edu>
Date: Wed, 02 Nov 2005 18:08:43 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE 4 ] Order-preserving file dbase
References: <43694616.3000002@cornell.edu>
In-Reply-To: <43694616.3000002@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> This patch restores the doubly-linked list that I got rid of earlier, 
> and uses it to implement order-preserving flush() operation. The 
> records are printed out in the order in which they're read in. 
> Additions go at the end of the file, and queries are executed starting 
> at the end of the file, and progressing up. This gets us closer to 
> solving The Port Problem.
Is the policydb order preserving? If I write a policydb, and read it 
back in, is the linked list of port contexts ordered the same way?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
