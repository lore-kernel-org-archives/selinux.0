Message-ID: <3FCF968B.3050504@diyab.net>
Date: Thu, 04 Dec 2003 15:18:19 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: mayerf@tresys.com
CC: "'Dhruv Gami'" <dgami@uncc.edu>, "'SELINUX'" <SELinux@tycho.nsa.gov>
Subject: Re: Basic question on policy design
References: <000401c3ba6a$ad593430$8100a8c0@columbia.tresys.com>
In-Reply-To: <000401c3ba6a$ad593430$8100a8c0@columbia.tresys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Frank Mayer wrote:

>>3. Are type_1 and type_2 interchangable in the above rule ?
> 
> 
> No.
> 

This is not entirely true.  I've run into instances where running 
something like apache and postgresql on the same SELinux machine will 
require the ability to speak to one another.  So for process to process 
you might end up with something like:

allow httpd_t postgresql_t:tcp_socket { recffrom acceptfrom };
allow postgresql_t httpd_t:tcp socket { recvfrom acceptfrom };

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
