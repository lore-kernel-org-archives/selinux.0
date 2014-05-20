Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4KG0Lba012547
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 12:00:21 -0400
References: <1400242442.444.9.camel@x220.localdomain>
 <53761EB7.5060906@tycho.nsa.gov> <537622CB.4060504@tycho.nsa.gov>
Message-ID: <1400601440.95536.YahooMailNeo@web87905.mail.ir2.yahoo.com>
Date: Tue, 20 May 2014 16:57:20 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: secilc: classmappings do not work
To: James Carter <jwcart2@tycho.nsa.gov>
In-Reply-To: <537622CB.4060504@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: selinux <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Just been testing the latest fix for expanding classmapping and found that if the
classes are unique, then it works okay. If there are repeated classes then I get
this error in the example below when the binary is being generated:
"Type default labeling for class binder already specified"


(class binder (impersonate call set_context_mgr transfer receive))
(class property_service (set))
(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))

(classpermissionset cps_zygote_1 (zygote (not (specifyids))))

; This works fine in the defaultuser statement:
(classmap single_set_classes (single_set))
(classmapping single_set_classes single_set
    (
        (binder (all))
        (property_service (set))
        (zygote (not (specifycapabilities)))
    )
)


; However with multiple classmapping secilc fails due to repeat classes:
(classmap multiple_set_classes (set_1 set_2 set_3))

(classmapping multiple_set_classes set_1
    (
        (binder (all))
        (property_service (set))
        (zygote (not (specifycapabilities)))
    )
)

(classmapping multiple_set_classes set_2
    (
        (binder (impersonate call set_context_mgr transfer))
        (zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith))
    )
)

(classmapping multiple_set_classes set_3
    (
        (cps_zygote_1)
        (binder (impersonate call set_context_mgr))
    )
)

(defaultuser (single_set_classes) source)

; The defaulttype statement gives the following error:
;;; Type default labeling for class binder already specified
(defaulttype (multiple_set_classes) target)





----- Original Message -----
> From: James Carter <jwcart2@tycho.nsa.gov>
> To: Dominick Grift <dominick.grift@gmail.com>; selinux <selinux@tycho.nsa.gov>
> Cc: 
> Sent: Friday, 16 May 2014, 15:38
> Subject: Re: secilc: classmappings do not work
> 
> On 05/16/2014 10:20 AM, James Carter wrote:
> 
>> 
>>  Also note that currently classmaps cannot be used in nametypetransition,
>>  rangetransition, type_rule, roletransition, validatetrans, default_user,
>>  default_role, default_type, or default_range rules.
>> 
> 
> I forgot to mention that I am currently working on this and should release a fix 
> 
> soon.
> 
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
