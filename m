Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9DNRxfD021987
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 19:27:59 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9DNRscs000188
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 23:27:59 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Capabilities audit field
Date: Mon, 13 Oct 2008 19:27:20 -0400
Cc: selinux@tycho.nsa.gov
References: <200810120907.07511.sgrubb@redhat.com> <200810130635.58500.sgrubb@redhat.com> <alpine.LRH.1.10.0810140953220.25832@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810140953220.25832@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810131927.20437.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 13 October 2008 18:54:50 James Morris wrote:
> >  570                case AVC_AUDIT_DATA_CAP:
> >  571                        audit_log_format(ab, " capability=%d",
> > a->u.cap); 572                        break;
>
> Nope, the capability number is correctly recorded in a->u.cap, and you'll
> also see capability2 as the tclass value.

avc:  denied  { ipc_owner } for  pid=4653 comm="ntpd" capability=15
scontext=root:system_r:ntpd_t tcontext=root:system_r:ntpd_t
tclass=capability

Hmm...the tclass field, being at the end, has not been parsed at the moment I 
need it to decide what capability we are talking about. tclass really should 
have been moved up nearer the beginning if its being used to determine how to 
interpret other fields. It would be nicer if there was some hint at whether 
we are dealing with a cap1 or cap2 capability before the capability field. I 
guess my other choice is to drop interpretation of capabilities in ausearch 
since now I don't know which set to use until after I've already printed what 
I thought it was.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
