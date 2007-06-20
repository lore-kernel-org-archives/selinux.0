Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KNcO4p026248
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 19:38:24 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5KNcKfi016188
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 23:38:22 GMT
Date: Wed, 20 Jun 2007 19:38:15 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Mike Eisler <email2mre-linuxv4@yahoo.com>
cc: selinux@tycho.nsa.gov, nfsv4@linux-nfs.org, Matthew.Dodd@sparta.com,
        Christopher.Vance@sparta.com, eparis@redhat.com, sds@tycho.nsa.gov
Subject: RE: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <558072.14557.qm@web31815.mail.mud.yahoo.com>
Message-ID: <Line.LNX.4.64.0706201934480.25962@localhost.localdomain>
References: <558072.14557.qm@web31815.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Jun 2007, Mike Eisler wrote:

> Interesting. This seems to have overlaps with the TNFS stuff
>   http://www.ietf.org/html.charters/OLD/tnfs-charter.html
> 
> which did produce an internet draft (draft-ietf-tnfs-spec-xx), but TNFS
> never got traction in the market, and apparently the WG folded before
> it produced an RFC.
> 
> 
> (Found an old version of the i-d at
> http://www.watersprings.org/pub/id/draft-ietf-tnfs-spec-01.txt
>  )

Indeed, some of the requirements for SENFS are based on earlier research 
(e.g. DTOS), which referenced TNFS as related work.  TNFS was considered 
too MLS-specific, whereas the Flask model used by SELinux is designed for 
for generic & flexible mandatory access control.

> > The intention is to get SENFS on the IETF standards track, so any 
> > assistance in that area would also be appreciated.
> 
> The NFSv4 WG will meet at the IETF meeting July 23.
> You should contact the WG chairs to
> see if you can get on the WG meeting's agenda. 
>   http://ietf.org/html.charters/nfsv4-charter.html

Thanks.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
