Message-ID: <43307A1D.3070806@cornell.edu>
Date: Tue, 20 Sep 2005 17:07:41 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: "'Stephen Smalley'" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>
In-Reply-To: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I agree that the duplication is strange, but I think that we should move all
>of these into libsemanage - I'm looking through them now and I don't see
>much reason for them to be in libsepol. This will only manage the files that
>store the users, right? Is the only goal a shared parser for the files? Same
>thing for ports.
>  
>
No - the semanage functionality is to extract data from a backend or 
write data to a backend, and to relay the corresponding objects to sepol 
to load (loading it itself breaks the encapsulation that I've been 
trying to create for sepol). The sepol functionality will be to actually 
load the data. Currently we're discussing the same data, hence the 
shared data structures, without modification. However, I'm not sure 
whether this will stay like that in the future - maybe we'll decide to 
store extra data in semanage that doesn't get passed down to the sepol 
layer. That's why I'm hesitant to use sepol data structures in semanage 
function headers.

>The inlined functions definitely don't make sense - the goals as I see them
>are:
>
>1) API/ABI stability
>2) The ability to move between straight modules and the policy server.
>
>The inlined functions don't meet this goal and moving things to libsepol
>will make 2 impossible.
>  
>
Can you clarify that point - I'm not sure I understand the problem. 
Perhaps it's an issue with inlined
functions that I'm not understanding - they're currently inlined for 
speed only, and that can easily be changed.
The point is to share the data structures with sepol, so the code 
doesn't have to be written twice.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
