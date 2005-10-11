Message-ID: <434BC8F2.8040502@cornell.edu>
Date: Tue, 11 Oct 2005 10:15:14 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] Replace semanage debugging system
References: <434B62B8.4080309@cornell.edu> <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> OTOH, __func__ is not known to older versions of gcc, and we already
> build with -D_GNU_SOURCE.  
>   
How much older? From the gcc webpage, I see it supported for 3.0+.
IMHO we should compile against a standard, not against a compiler..
> An obvious concern about the new msg_write function is that it requires
> memory allocation itself.  Thus, on a memory allocation failure in the
> caller, we might easily end up dropping the out of memory error message
> due to lack of available memory at this point.
>   
By the way, does the printf family require such a memory allocation?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
