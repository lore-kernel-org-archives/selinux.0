Message-ID: <442D41CA.8070702@redhat.com>
Date: Fri, 31 Mar 2006 09:50:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: The sort algorithm is broken by the second rule,  We need a way to
 pin these rules to the top.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/usr(/.*)?/lib(64)?(/.*)?            gen_context(system_u:object_r:lib_t,s0)
/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*    --    
gen_context(system_u:object_r:shlib_t,s0)

The following has to follow the one above.

/usr/lib(64)?/libglide3\.so.*         --    
gen_context(system_u:object_r:textrel_shlib_t,s0)


It did in FC4, now it does not.  This is the second bug I have seen 
caused by the sort algoritm.  We need a way to secify a primary File 
Context file that will not be sorted but will always be at the top.  
Then the rest can be sorted.

Maybe we do not sort files within a particular fc file.  I do not know. 
but this is broken.



Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
