Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4GFFW8k002474
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 11:15:34 -0400
Received: from cluster-j.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4GFFW6d009021
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 15:15:33 GMT
Received: from rly44j.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly44j.srv.mailcontrol.com (MailControl) with ESMTP id p4GFFL5j018936
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 16:15:21 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly44j.srv.mailcontrol.com (MailControl) id p4GFFGu4018785
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 16:15:16 +0100
From: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 16 May 2011 16:15:11 +0100
Subject: RE: Patch Review Process
Message-ID: <A9F5079BABDEE646AEBDB6831725762C556019529B@EUEXCLU01.EU.NEC.COM>
References: <4DC804D8.1080605@tresys.com> <1304968880.2521.43.camel@vortex>
 <4DC84776.8080708@tresys.com>
 <A9F5079BABDEE646AEBDB6831725762C55601124C2@EUEXCLU01.EU.NEC.COM>
 <4DD13501.1060406@tresys.com>
In-Reply-To: <4DD13501.1060406@tresys.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I'm looking around for something that would work well. Is commitfest
> custom built by the postgresql community or is it some open source
> project? I can't seem to find any information on what the backend is.
>
It is custom build by the postgresql community.

Because it is not a large application, I'm available to make similar one
with arranges for our community, if we want.
(Is PHP and PostgreSQL available on selinuxproject.org ?)

Thanks,
--
NEC Europe Ltd, SAP Global Competence Center
KaiGai Kohei <kohei.kaigai@emea.nec.com>


> -----Original Message-----
> From: Steve Lawrence [mailto:slawrence@tresys.com]
> Sent: 16. Mai 2011 15:30
> To: Kohei Kaigai
> Cc: SELinux
> Subject: Re: Patch Review Process
> 
> I'm looking around for something that would work well. Is commitfest
> custom built by the postgresql community or is it some open source
> project? I can't seem to find any information on what the backend is.
> 
> On 05/13/2011 05:28 AM, Kohei Kaigai wrote:
> > As a proposal to improve our project, how about adopting patch management system on
> > selinuxproject.org site?
> >
> > In PostgreSQL community, we use this simple system to manage patches submitted.
> >
> >   https://commitfest.postgresql.org/action/commitfest_view?id=10
> >
> > It enables to track the current status, activities and responsibility of patches.
> >
> > It seems to me 30 of patches are too large to manage without systematic helps.
> >
> > [snip]
> >> Current Patch Queue:
> >>
> >> checkpolicy: fix filename identifier
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=130442985211760&w=2
> >>
> >> selabel_open fix processing of substitution files (update)
> >> Richard Haines <richard_c_haines@btinternet.com>
> >> http://marc.info/?l=selinux&m=130314146920796&w=2
> >>
> >> selinux_file_context_verify function returns wrong value
> >> Richard Haines <richard_c_haines@btinternet.com>
> >> http://marc.info/?l=selinux&m=129968866831934&w=2
> >>
> >> Fix boolean handling in semanage
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=125433524126271&w=2
> >>
> >> Add modules support to semanage
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=125433587727297&w=2
> >>
> >> sandbox changes
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226611027331&w=2
> >>
> >> libselinux mountpoint changing
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=130444622801373&w=2
> >>
> >> Add note to checkmodule man page about versions
> >> Jason Axelson <jaxelson@referentia.com>
> >> http://marc.info/?l=selinux&m=127913558418720&w=2
> >>
> >> Bug in restorecond for the first user logged in
> >> Chris Adams <cmadams@hiwaay.net>
> >> http://marc.info/?t=128164314700001&r=1&w=2
> >>
> >> transactions in semanage man page
> >> Russell Coker <russell@coker.com.au>
> >> http://marc.info/?l=selinux&m=127959379422398&w=2
> >>
> >> libsemanage python3 support
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=128025784525867&w=2
> >>
> >> libselinux python3 support
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226509225674&w=2
> >>
> >> SETools patch: adding exclude type feature in queries
> >> Roberto Sassu <roberto.sassu@polito.it>
> >> http://marc.info/?l=selinux&m=128448149528834&w=2
> >>
> >> Move newrole to file caps/libcapng
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226621227513&w=2
> >>
> >> Improve semodule performance
> >> Matthew Robertson <Matthew.L.Robertson@boeing.com>
> >> http://marc.info/?l=selinux&m=128043503603540&w=2
> >>
> >> Fix warning messages generated by GCC 4.6
> >> Justin P. Mattock <justinmattock@gmail.com>
> >> http://marc.info/?l=selinux&m=127845525722194&w=2
> >>
> >> sepolgen kernel policy version check
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=128948444127169&w=2
> >>
> >> Remove DEFAULTUSER handling from get_context_list
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226509425687&w=2
> >>
> >> sepolgen current patch from Fedora
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226551726416&w=2
> >>
> >> Improved error message for load_policy
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226567426640&w=2
> >>
> >> Semanage patch
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129233335310866&w=2
> >>
> >> restorecond: Ignore IN_IGNORED inotify events
> >> Martin Orr <martin@martinorr.name>
> >> http://marc.info/?l=selinux&m=125380417916233&w=2
> >>
> >> setfiles/restorecond patch
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226589026919&w=2
> >>
> >> policycoreutils:  update audit2allow manpage
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129304945226866&w=2
> >>
> >> libsemanage: include MCS/MLS level when generating files_contexts.homedirs
> >> Russell Coker <russell@coker.com.au>
> >> http://marc.info/?l=selinux&m=129421658323663&w=2
> >>
> >> setfiles: provide an option to avoid abortion on a missing file
> >> Guido Trentalancia <guido@trentalancia.com>
> >> http://marc.info/?l=selinux&m=129819885027010&w=2
> >>
> >> minor improvements and clean-ups for setfiles
> >> Guido Trentalancia <guido@trentalancia.com>
> >> http://marc.info/?l=selinux&m=129819262321520&w=2
> >>
> >> policycoreutils scripts updates
> >> Daniel J Walsh <dwalsh@redhat.com>
> >> http://marc.info/?l=selinux&m=129226648427897&w=2
> >>
> >> Fix options for policycoreutils binaries
> >> Guido Trentalancia <guido@trentalancia.com>
> >> http://marc.info/?l=selinux&m=125718355929168&w=2
> >>
> > --
> > NEC Europe Ltd, SAP Global Competence Center
> > KaiGai Kohei <kohei.kaigai@emea.nec.com>
> 
> 
> 
>  Click
> https://www.mailcontrol.com/sr/inBW9VIHWgDTndxI!oX7Ui!B!9hWdHWJGFxbtvmLXXIuo7oVvculFYwkjKcDqr6Q0+
> EvhqRAbnWOd!jBVaBGJg==  to report this email as spam.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
