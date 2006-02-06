Message-ID: <43E6A154.5010608@cornell.edu>
Date: Sun, 05 Feb 2006 20:07:32 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [SEPOL][SEMANAGE] Nodecon Support: Try 1
References: <43E667C2.6050001@cornell.edu>
In-Reply-To: <43E667C2.6050001@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>  When working with strings, pton/ntop are used to convert to byte 
> arrays, which are the record's internal representation - more compact, 
> and allows comparison of two addresses. This means the protocol is 
> passed into set_addr() and set_mask() to control which function is 
> used (see below on the protocol being made explicit).
s/"which function"/"which namespace"/ i.e. AF_INET or AF_INET6.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
