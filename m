Message-ID: <20050107082301.94911.qmail@web51502.mail.yahoo.com>
Date: Fri, 7 Jan 2005 00:23:01 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: BUG in security_context_to_sid() ?
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
    I'm now learning SELinux hook function. so, I try
to write such a hook (Just for learning), shown as the
following (I'm using Fedora Core 2,  kernel:
2.6.5-1.358custom):

static int selinux_check_permission(char
*securitycontext_to_be_checked)
{
        int err = 0;
        u32 sid;
        struct avc_audit_data ad;
        AVC_AUDIT_DATA_INIT(&ad, NET);

        err =
security_context_to_sid(securitycontext_to_be_checked,
strlen(securitycontext_to_be_checked), &sid);
        if (err)
                goto out;

        tsec = current->security;
        err = avc_has_perm(tsec->sid, sid,
SECCLASS_SOCKET, SOCKET__CREATE, NULL, &ad);
                                                      
out:
        return err;
}


    But, every time, when security_context_to_sid() is
called in the hook, the kernel yield a oops as the
following:


Debug: sleeping function called from invalid context
at mm/slab.c:1980
in_atomic():1, irqs_disabled():0
Call Trace: [<0211691d>]  [<02130a17>]  [<02189857>] 
[<021837a6>]  [<02294651>]  [<02118840>]  [<021189cd>]
 [<02263e84>]  [<0227a3e4>]  [<0227a465>] 
[<0227a953>]  [<0218befb>]  [<0218bc23>]  [<02194118>]
 [<0218d90d>]  [<0218c25f>]  [<0218b132>] 
[<021894f4>]  [<021895f5>]  [<0217f686>]  [<0217f728>]
 [<021835ff>]
[<0227ac21>]  [<0227452a>]  [<0227af39>]  [<0227b3cd>]
 [<02264f19>]  [<022652e7>]  [<02253332>] 
[<1195048f>]  [<119506af>]  [<02253495>]  [<0211af6d>]
 [<021078b1>]  =======================
 [<02107337>]  [<118aeb59>]  [<118aefba>] 
[<118adab2>]  [<02116b21>]  [<02116b21>]  [<022a2301>]
 [<02115ed2>]  [<118afbfe>]  [<02116b21>] 
[<02116b21>]  [<118afb58>]  [<118afb5e>]  [<021041cd>]

    
    After I've transformed the oops with ksymoops, it
looked like the following:


ksymoops 2.4.9 on i686 2.6.5-1.358custom.  Options
used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.5-1.358custom/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Call Trace: [<0211691d>]  [<02130a17>]  [<02189857>] 
[<021837a6>]  [<02294651>]  [<02118840>]  [<021189cd>]
 [<02263e84>]  [<0227a3e4>]  [<0227a465>] 
[<0227a953>]  [<0218befb>]  [<0218bc23>]  [<02194118>]
 [<0218d90d>]  [<0218c25f>]  [<0218b132>] 
[<021894f4>]  [<021895f5>]  [<0217f686>]  [<0217f728>]
 [<021835ff>]
[<0227ac21>]  [<0227452a>]  [<0227af39>]  [<0227b3cd>]
 [<02264f19>]  [<022652e7>]  [<02253332>] 
[<1195048f>]  [<119506af>]  [<02253495>]  [<0211af6d>]
 [<021078b1>]  =======================
 [<02107337>]  [<118aeb59>]  [<118aefba>] 
[<118adab2>]  [<02116b21>]  [<02116b21>]  [<022a2301>]
 [<02115ed2>]  [<118afbfe>]  [<02116b21>] 
[<02116b21>]  [<118afb58>]  [<118afb5e>]  [<021041cd>]
Warning (Oops_read): Code line not seen, dumping what
data is available

Trace; 0211691d <__might_sleep+80/8a>
Trace; 02130a17 <__kmalloc+40/76>
Trace; 02189857 <security_context_to_sid+72/1e9>
Trace; 021837a6 <selinux_check_permission+5e/9b>
 ... ...
 ... ...
1 warning issued.  Results may not be reliable.


   Then Is there any bug in security_context_to_sid()
function that cause such a oops? or has it already
been modified now?

   Thank you very much.
 


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
