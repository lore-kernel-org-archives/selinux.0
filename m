Message-ID: <4331A852.9070005@cornell.edu>
Date: Wed, 21 Sep 2005 14:37:06 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: "'Stephen Smalley'" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <200509211748.j8LHmnYs012526@gotham.columbia.tresys.com>
In-Reply-To: <200509211748.j8LHmnYs012526@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Just a note - there is a working policy server right now
>(sepolicy-server.sf.net has the latest release). That is why these
>functions, at the very least, need to be indirected through the
>semanage_handle_t function pointers so different versions can be plugged in
>for the remote implementation.
>  
>
These functions should be implemented exactly the same way, regardless 
of backend of the policy.
Those are data structure wrappers. They provide virtually no 
functionality other than accessors for the data
in the structure.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
