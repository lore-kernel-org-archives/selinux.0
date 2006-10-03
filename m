Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LsCYB027873
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:54:12 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93LrZGw020167
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:53:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: init unconfined in RHEL4?
Date: Wed, 4 Oct 2006 07:54:03 +1000
Cc: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>, selinux@tycho.nsa.gov
References: <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu> <7B95239DDD54E54B9BFA23847142B1EE10A29E@aplesnation.dom1.jhuapl.edu> <4522CFC7.7040801@redhat.com>
In-Reply-To: <4522CFC7.7040801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610040754.06676.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 04 October 2006 07:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Osborn, Justin D. wrote:
> > I'm working on a RHEL4 system with the Reference Policy and init is
> > running in unconfined_t.  This leads to most other processes on the
> > system running in unconfined_t.  Has anyone seen similar errors?
>
> In RHEL4 only 15 Targets are confined,  Everything else runs in an
> unconfined domain.
>
> > This is the Ref. Policy version released in March, I got the latest
> > svn version but it doesn't work with the libsepol and checkpolicy
> > RHEL4 RPMs on the Tresys site.

Justin, the problem is that you are running a non-standard policy on RHEL4.

If you run the back-port of the reference policy on RHEL4 then Red Hat won't 
support you and most developers won't be interested as development happens on 
Rawhide.

If you have problems with Refpolicy on RHEL4 and can reproduce them on FC6test 
releases then many people will be interested in investigating the problems.  
But if it's only a problem for Refpolicy on RHEL4 then you are probably on 
your own.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
