Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3D1Men3030518
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2010 21:22:44 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3D1MDQO008026
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 01:22:14 GMT
Received: by vws9 with SMTP id 9so13677vws.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2010 18:22:42 -0700 (PDT)
Message-ID: <4BC3C7A8.6070109@gmail.com>
Date: Mon, 12 Apr 2010 18:23:52 -0700
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: AVC accesing shadow during gnome login
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/12/2010 12:24 PM, Alan Rouse wrote:
> I'm getting the following when I log in via the gnome login gui
> (OpenSUSE 11.2) with dontaudit turned off:
> type=AVC msg=audit(1271099674.777:3): avc: denied { read } for pid=2475
> comm="gdm-session-wor" name="shadow" dev=sda2 ino=129609
> scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file
> type=AVC msg=audit(1271099674.780:4): avc: denied { open } for pid=2475
> comm="gdm-session-wor" name="shadow" dev=sda2 ino=129609
> scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file
> type=AVC msg=audit(1271099674.792:5): avc: denied { getattr } for
> pid=2475 comm="gdm-session-wor" path="/etc/shadow" dev=sda2 ino=129609
> scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file
> But I think the required access is prohibited via 'neverallow'.
> Suggestions welcome.
> Thanks


I think shadow is always rejected by the policy,
and chkpwd is allowed.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
