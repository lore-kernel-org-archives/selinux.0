Message-ID: <43320DE5.9080802@cornell.edu>
Date: Wed, 21 Sep 2005 21:50:29 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: "'Stephen Smalley'" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <200509211833.j8LIXGYs013694@gotham.columbia.tresys.com>
In-Reply-To: <200509211833.j8LIXGYs013694@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Not certain what you mean - in the case of the policy server, the client
>might be running on a different machine than the server. That means that
>these functions would have to do some form of RPC using a wire protocol. You
>can look at the old policy server snapshot to see this.
>  
>
I mean... the functions in *_record.h pack and unpack records, and don't 
do anything else of significance - they don't retrieve the record, or 
parse the record, or anything. As such, I don't see why you'd be using 
RPC on them - there's no reason for a client to be invoking those 
functions on a different machine.


 






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
