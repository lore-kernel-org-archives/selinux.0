Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u12IQh4d020132
 for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2016 13:26:43 -0500
Received: by mail-pf0-f182.google.com with SMTP id w123so16636826pfb.0
 for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2016 10:26:40 -0800 (PST)
Date: Wed, 3 Feb 2016 02:26:35 +0800
From: Jason Zaman <jason@perfinion.com>
To: Mark Steele <mark@control-alt-del.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux file context matching
Message-ID: <20160202182635.GA29269@meriadoc>
References: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
 <56B0F257.60504@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B0F257.60504@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 02, 2016 at 01:15:51PM -0500, Stephen Smalley wrote:
> On 02/02/2016 12:48 PM, Mark Steele wrote:
> > Hi list,
> >
> > I've got some file contexts setup for an application, and can't get the
> > file context matching to work as I would expect.
> >
> > [root@dev1 policy]# cat
> > /etc/selinux/targeted/contexts/files/file_contexts | grep cinched
> > /etc/cinched(/.*)?      system_u:object_r:ts_etc_t:s0
> > /var/log/cinched(/.*)?  system_u:object_r:ts_log_t:s0
> > /var/lib/cinched(/.*)?  system_u:object_r:ts_t:s0
> > */usr/lib64/cinched(/.*)?        system_u:object_r:ts_lib_t:s0*
> > /etc/bash_completion.d/cinched_bash_completions
> > system_u:object_r:ts_etc_t:s0
> > /var/log/cinched/audit(/.*)?    system_u:object_r:ts_audit_log_t:s0
> > /usr/sbin/cinched       system_u:object_r:ts_exec_t:s0
> >
> > [root@dev1 policy]# matchpathcon /usr/lib64/cinched/
> > */usr/lib64/cinched      system_u:object_r:lib_t:s0*
> >
> > [root@dev1 policy]# findcon
> > /etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/cinched
> > /.*             system_u:object_r:default_t:s0
> > /usr/.*         system_u:object_r:usr_t:s0
> > */usr/lib64/cinched(/.*)?                system_u:object_r:ts_lib_t:s0*
> >
> >
> > This is running on CentOS 7. I was assuming that since my rule has the
> > longest stem, it would be applied.
> >
> > Any suggestions?
> 
> It would help to see the complete file_contexts file.
> Do you have anything in file_contexts.local that could be overriding it?

Also, file_contexts.subs*. /usr/lib64 and 32 are usually aliased to
/usr/lib so your fcontexts needs to be /usr/lib/cinched(/.*)? instead of
with the 64.
