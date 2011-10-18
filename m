Message-ID: <4E9D7267.9060004@tresys.com>
Date: Tue, 18 Oct 2011 08:34:47 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, David Windsor <dwindsor@gmail.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
References: <4E7B9233.6080609@redhat.com>  <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>  <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>  <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>  <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com> <1317139611.22218.9.camel@moss-pluto> <4E82123C.4070406@redhat.com> <4E985BFB.1000806@redhat.com>
In-Reply-To: <4E985BFB.1000806@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/14/11 11:57, Daniel J Walsh wrote:
> Eric and I have come up with the following syntax for this behaviour.
> 
> default_trans level dir_file_class_set parent;

I think we want this to be "range" instead of "level", since the field is actually a range.

> default_trans user dir_file_class_set process;
> default_trans role file parent;

Isn't there a better set of tokens than this?  Why not make it default_user, default_role, default_type, and default_range?  Creating an object doesn't really imply a transition, so "trans" seems misleading.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
