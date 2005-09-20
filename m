Message-ID: <43308255.6080007@cornell.edu>
Date: Tue, 20 Sep 2005 17:42:45 -0400
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


>2) The ability to move between straight modules and the policy server.
>
>The inlined functions don't meet this goal and moving things to libsepol
>will make 2 impossible.
>  
>
I don't understand what's preventing you from reimplementing those 
functions at any point in time, as long as the data structures are 
opaque (which they are). Yes, the functions are inlined, and the callers 
may decide that they'll always be equivalent to the sepol ones, but I 
think at that point the caller is not using the interface properly, and 
we shouldn't care.

Since there is no policy server right now, and there is a policydb, 
where the same data structures are already implemented, serving pretty 
much the same purpose (encapsulation), it seems easy to just make use of 
those functions. It also seems like you'll need to link to libsepol for 
a long time, to handle the policydb case even after the policy server is 
created.

Regardless, I don't care anymore - if you guys want to duplicate all the 
records into semanage, then that's fine with me - I can write a patch 
for it, if that is your decision. I think Steven's arguing for the exact 
opposite of that (unless I misunderstood) - use of sepol records 
directly. I just want some data structure that I can use in my record 
engine, regardless of where it came from - all I need for it is to fill 
out the record_table found in record_file.h.

Other issues: will you be merging the handle stuff soon? I need the 
handle to implement any kind of error reporting in my code (because 
otherwise I'd just be changing interfaces later). I think I'll likely 
submit a patch with the record engine stuff, and comment out all the 
DEBUG calls to be fixed later.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
