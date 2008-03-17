Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2HJwl9T008498
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 15:58:47 -0400
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2HJwkCw019650
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 19:58:47 GMT
Received: by wf-out-1314.google.com with SMTP id 28so5973017wfc.30
        for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 12:58:32 -0700 (PDT)
Message-ID: <dd18b0c30803171117p8d400dfk28c7168723b7b2e@mail.gmail.com>
Date: Mon, 17 Mar 2008 18:17:18 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: 2.6.25
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry to get you confused, (I feel like a blind man that cant read
braille) with fglrx inside the scripting there is a call for
KCL_PosixSecurityCapGetEffectiveVector:(below)

KCL_TYPE_Cap ATI_API_CALL KCL_PosixSecurityCapGetEffectiveVector()
{
    return cap_t(current->cap_effective);
}
void ATI_API_CALL KCL_PosixSecurityCapSetEffectiveVector(KCL_TYPE_Cap cap)
{
    cap_t(current->cap_effective) = cap;
}

Like what you said about the bit being changed this is probably what
I'm looking at (cap_t is no longer in there)
There error is this:(below)

/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c: In function
'KCL_PosixSecurityCapGetEffectiveVector':
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c:1888: error:
implicit declaration of function 'cap_t'
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c: In function
'KCL_PosixSecurityCapSetEffectiveVector':
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c:1896: error:
invalid lvalue in assignment

How hard is it to go in and change the old capability requests to fit
the new capability.h ?


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
