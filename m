Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Diyab'" <diyab@diyab.net>
Cc: "'Dhruv Gami'" <dgami@uncc.edu>, "'SELINUX'" <SELinux@tycho.nsa.gov>
Subject: RE: Basic question on policy design
Date: Tue, 9 Dec 2003 12:05:43 -0500
Message-ID: <003701c3be76$aea51a60$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FCF968B.3050504@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> 3. Are type_1 and type_2 interchangable in the above rule ?
>> 
>> No.
> 
> This is not entirely true.  I've run into instances where running
> something like apache and postgresql on the same SELinux machine will
> require the ability to speak to one another.  So for process to
> process you might end up with something like:
> 
> allow httpd_t postgresql_t:tcp_socket { recffrom acceptfrom };
> allow postgresql_t httpd_t:tcp socket { recvfrom acceptfrom };

Just to be precise, for a given policy you may need to make access between two
types reciprocal as in the above example.  However, I stand by my answer to the
original question: one cannot interchange the source and target types in a given
allow rule with the two resultant rules having the same semantic meaning.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
