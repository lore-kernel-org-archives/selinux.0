Message-ID: <4E9F0D47.5060304@manicmethod.com>
Date: Wed, 19 Oct 2011 13:47:51 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        David Windsor <dwindsor@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
References: <4E7B9233.6080609@redhat.com>  <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>  <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>  <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>  <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com> <1317139611.22218.9.camel@moss-pluto> <4E82123C.4070406@redhat.com> <4E985BFB.1000806@redhat.com> <4E9D7267.9060004@tresys.com> <4E9EED35.8070408@manicmethod.com> <4E9F0BBE.8070105@redhat.com>
In-Reply-To: <4E9F0BBE.8070105@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> We can parse and you are allowed to use process in both places.

Even still, SELinux does not internally (either in the security server or the 
compiler) know what a process is and some users of the compiler have a different 
concept of subject than Linux does (e.g., Xen)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
