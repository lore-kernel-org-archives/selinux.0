Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KDErrT003616
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:14:54 -0400 (EDT)
Received: from wgimx01.wgint.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KDEpQ4025357
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:14:52 GMT
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Stefan SF" <stefan@sf-net.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: policy for scponly - need help
Date: Fri, 20 Aug 2004 07:16:48 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOGEMHCEAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040820080156.GA8602@crux.sternplastic>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello-

I'm just a newbie at this, but it looks like a term is missing from your
last 'allow' statement. Perhaps it should be:

allow user_t self:capability { dac_override dac_read_search };

Richard

> Hi!
>
> > scponly seems similar to rssh.  You may want to try my rssh policy:
> > http://verbum.org/files/rssh_macros.te
> > http://verbum.org/files/rssh.te
> > http://verbum.org/files/rssh.fc
>
> Hmm I can't make head or tail of this. I think the
> scponly-problem is another one. Because you don't have to transit
> or anything else in the rssh-policy (user -> role).
>
> > It would likely be sufficient to just add a regexp for scponly to
> > rssh.fc.
>
> For what? I think this is not a problem of correct labeling.
>
> > Hmmm, odd.  Are you logging in as root?
>
> No, the program is only to /usr/sbin installed because it uses
> some functions which are only to priviliged peoples related, I think.
>
>
> I've created policies all the time ;-) but nothing right was
> coming out! I've still the same problem, that I can't allow the
> user_t capabilities, without edeting the uesr.te files! It would
> be great, if I only have to edit the scponly-policy-files. I
> think all permissions for the program should go there.
>
> Here is on of my tries:
>
> # domains/program/scponly.te
> type scponly_t, domain, privowner;
> type scponly_exec_t, file_type, exec_type, sysadmfile;
>
> domain_auto_trans(user_t, scponly_exec_t, scponly_t)
> domain_auto_trans(sysadm_t, scponly_exec_t, scponly_t)
>
> role user_r types scponly_t;
> role sysadm_r types scponly_t;
>
> ifdef(`ssh.te',`
> allow sshd_t scponly_exec_t:file { getattr execute read };
> allow user_t scponly_exec_t:file { entrypoint };
> ')
>
> ifdef(`user.te',`
> allow user_t:capability { dac_override dac_read_search };
> domain_auto_trans(user_t, scponly_exec_t, scponly_$1_t);
> ')
>
>
> I thought with a domain_auto_trans the problem should get fixed,
> but the output from avc is still the same.
>
> audit(1092988519.353:0): avc:  denied  { dac_override } for
> pid=7088 exe=/usr/sbin/scponlyc capability=1
> scontext=test:user_r:user_t tcontext=trade:user_r:user_t tclass=capability
> audit(1092988519.353:0): avc:  denied  { dac_read_search } for
> pid=7088 exe=/usr/sbin/scponlyc capability=2
> scontext=test:user_r:user_t tcontext=trade:user_r:user_t tclass=capability
>
>
> Any hints, tipps or related policy-files would be great! ;-)
>
>
> ciao, Stefan
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
