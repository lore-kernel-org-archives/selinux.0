Message-ID: <3F662A3A.4010408@iitk.ac.in>
Date: Tue, 16 Sep 2003 02:38:10 +0530
From: kamal <kamalnee@iitk.ac.in>
MIME-Version: 1.0
To: Trent Jaeger <jaegert@us.ibm.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: SELinux project
References: <OFF5A0ED70.9B405226-ON85256DA2.00673487-85256DA2.006B8345@us.ibm.com>
In-Reply-To: <OFF5A0ED70.9B405226-ON85256DA2.00673487-85256DA2.006B8345@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks a lot for the suggestions!
Our interest related to integrity is slightly different. SELinux seems 
to take good care of the security of the system. But consider a military 
environment and think about actual users. A high ranking officer has got 
lots of documents from juniors and his boss, some of them possibly 
copied from their directories, and some sent through email. Now all the 
documents should not appear same to him, there should be an easy 
classification based on integrity and confidentiality of a document. He 
should not unknowingly be able to move information in a way that 
violates Biba and BLP constraints. We also want to see how digital 
signatures and encryption can be tightly and transparently integrated 
with this, e.g. in assigning integrity level to an incoming email 
attachment.
Another thing in our mind is decentralization of users' 
confidentiality/integrity levels. I mean putting this policy on some 
central server. After all, users don't belong to a computer, they belong 
to an organization. Decentralizing parts of general TE policy seems more 
difficult, levels seem easier to handle.
I wonder whether all this makes sense. Does it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
