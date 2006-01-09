Message-ID: <43C28A9F.2070600@redhat.com>
Date: Mon, 09 Jan 2006 11:09:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Auditallow execmem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Currently there are too many applications that need execmem, to turn off 
allow_execmem by default.  So I changed the policy
to auditallow execmem if there allow_execmem is set.  This allows us to 
at least discover applications in targeted policy that need
this priv, and then submit bugzillas for those apps, or fix policy to 
allow them if it really is needed.   The problem is that these messages 
are not rate limited so you can end up with hundreds or thousands of 
these messages in the log file.  What do you think about limiting 
auditallow message to once similar to the way we do in permissive mode?  
Since this is by it's nature permissive.  IE One pessage per PID.


type=AVC msg=audit(1136817016.558:1419): avc:  granted  { execmem } for  
pid=2774 comm="firefox-bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136817512.277:1420): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136818328.051:1421): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136819443.464:1428): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136820377.510:1429): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136821309.091:1435): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
type=AVC msg=audit(1136822165.482:1438): avc:  granted  { execmem } for  
pid=3208 comm="soffice.bin" scontext=user_u:system_r:unconfined_t:s0 
tcontext=user_u:system_r:unconfined_t:s0 tclass=process
...

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
