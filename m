Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GKeb64004149
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:40:37 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5GKebIg023139
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 20:40:37 GMT
Received: by wr-out-0506.google.com with SMTP id 58so673701wri
        for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 13:40:36 -0700 (PDT)
Message-ID: <80d7e4090606161340u34cfb315qb6031ce1710dde82@mail.gmail.com>
Date: Fri, 16 Jun 2006 14:40:35 -0600
From: "Stephen John Smoogen" <smooge@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [redhat-lspp] Got up at 5 AM, and thought I would try to write a new role
Cc: "Steve Grubb" <sgrubb@redhat.com>, redhat-lspp@redhat.com,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <44931075.5070208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44930D28.2010103@redhat.com>
	 <200606161601.38912.sgrubb@redhat.com> <44931075.5070208@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/16/06, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Steve Grubb wrote:
> > On Friday 16 June 2006 15:57, Daniel J Walsh wrote:
> >
> >> I wanted to try to create an auditadm_r.
> >>
> >
> > Didn't you mean httpdadm_r  :)
> >
> > I think we should bust up the systemadm role a little more and make it
> > composed of some other roles. RBAC says we are supposed to support
> > composition, so we can use it here.
> >
> > Some other roles might be backup admin, db admin. mail admin.
> >
> > -Steve
> >
> backupadm might be pretty tough, since I don't believe we run type
> enforcement on any backup tools
> so you would need to be able to read/write every file on the system, and
> I see little benefit in this.
>

I think for some servers, there is a need to restrict backup
priveledges to certain areas versus the entire system. [Areas being
easier to control security levels with.. but I could see where we
would want at least 4 different backup tools running: Open,
Confidential, Secret, TopSecret..] There might also be needs where
read is ok but write is not unless authorized by a different
mechanism.

Not sure if this needs a seperate backup_adm mode or other mechanisms.

-- 
Stephen J Smoogen.
CSIRT/Linux System Administrator

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
