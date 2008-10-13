Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9DMtCbm018715
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 18:55:13 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9DMrt23002595
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 22:53:56 GMT
Date: Tue, 14 Oct 2008 09:54:50 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Steve Grubb <sgrubb@redhat.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Capabilities audit field
In-Reply-To: <200810130635.58500.sgrubb@redhat.com>
Message-ID: <alpine.LRH.1.10.0810140953220.25832@tundra.namei.org>
References: <200810120907.07511.sgrubb@redhat.com> <alpine.LRH.1.10.0810131009520.16356@tundra.namei.org> <200810130635.58500.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Oct 2008, Steve Grubb wrote:

> Then does this need some updating in avc.c ?
> 
>  570                case AVC_AUDIT_DATA_CAP:
>  571                        audit_log_format(ab, " capability=%d", a->u.cap);
>  572                        break;

Nope, the capability number is correctly recorded in a->u.cap, and you'll 
also see capability2 as the tclass value.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
