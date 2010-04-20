Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3KI9css010816
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 14:09:38 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o3KIAZEM010159
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 18:10:35 GMT
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
References: <4BCC69C0.5040502@redhat.com>
	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 20 Apr 2010 14:09:37 -0400
Message-ID: <1271786977.32279.29.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-20 at 10:37 -0400, Karl MacMillan wrote:
> On Mon, Apr 19, 2010 at 11:53 AM, Karl MacMillan
> <karlwmacmillan@gmail.com> wrote:
> > On Mon, Apr 19, 2010 at 10:33 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>
> >> If you look at the interface userdom_read_home_certs.
> >>
> >> [InterfaceVector userdom_read_home_certs $1:source ]
> >> $1,home_cert_t,file,read,lock,getattr,open,ioctl
> >> $1,home_cert_t,dir,ioctl,search,read,lock,open,getattr
> >> $1,home_cert_t,lnk_file,read,getattr
> >> $1,home_root_t,dir,getattr,open,search
> >> $1,home_root_t,lnk_file,read,getattr
> >> $1,user_home_dir_t,dir,getattr,open,search
> >> $1,user_home_dir_t,lnk_file,read,getattr
> >>
> >> A domain that is allowed to search the homedir is always going to
> >> generate an AVC that is a long way off.
> >>
> >
> > Seems to me that the problem is that the read / getattr on
> > user_home_dir_t directories and files is adding too much distance.
> >
> 
> I looked at this a bit more - there are a few interesting issues:
> 
> 1. The open permissions have not been added to the perm_map file
> (patch attached to fix that). When there is no perm map then we weight
> the permission at 5 and assume read and write. Since we heavily
> penalize providing a write interface for a read access request, this
> causes the return of a large distance (as I believe that it should).
> I'd like to find a long term home for the perm map file that increases
> it's likelihood of being updated with new permissions (Chris - what do
> you think of including this with reference policy?).

I'm fine with it, just as long as the output perm map file has a
agreed-upon standard format.  It looks like sepolgen has the same format
as setools, so that probably won't be a problem (unless there are other
tools with perm maps that I am unaware of).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
