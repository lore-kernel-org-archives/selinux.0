Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJt6Nm029190
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:55:06 -0400
Message-ID: <46291A98.2040003@tycho.nsa.gov>
Date: Fri, 20 Apr 2007 15:55:04 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
 to	libsepol
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
In-Reply-To: <20070420133430.9884.86379.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Add a generic iterator data structure and a linked-list implementation
> based that uses the iterators to libsepol. Includes test cases for the
> linked-list implementation.
> 
> This version is updated to remove improper use of void** based on comments 
> from James Antill.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>

Is there no standard utility library out there that could provide these 
things?  Glib?  APR?


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
