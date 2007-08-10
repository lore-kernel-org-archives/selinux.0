Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AF5GBn011823
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 11:05:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7AF5E1t004117
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 15:05:14 GMT
Subject: Re: [PATCH] refpolicy: kernel_kernel changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46BC6555.9010802@redhat.com>
References: <200708022004.l72K4Ome029700@redsox.boston.devel.redhat.com>
	 <1186497721.18881.27.camel@gorn>  <46BC6555.9010802@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Aug 2007 15:04:37 +0000
Message-Id: <1186758277.25504.33.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-10 at 09:17 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2007-08-02 at 16:04 -0400, dwalsh@redhat.com wrote:
> >   
> >> Additional interfaces for kernel access
> >>
> >> @@ -1848,6 +1866,27 @@
> >>
> >>  ########################################
> >>  ## <summary>
> >> +##     Read the process state (/proc/pid) of all unlabeled_t.
> >> +## </summary>
> >> +## <param name="domain">
> >> +##     <summary>
> >> +##     Domain allowed access.
> >> +##     </summary>
> >> +## </param>
> >> +#
> >> +interface(`kernel_read_unlabeled_state',`
> >> +       gen_require(`
> >> +               type unlabeled_t;
> >> +       ')
> >> +
> >> +       allow $1 unlabeled_t:dir list_dir_perms;
> >> +       read_files_pattern($1,unlabeled_t,unlabeled_t)
> >> +       read_lnk_files_pattern($1,unlabeled_t,unlabeled_t)
> >> +')
> >>     
> >
> > I'm concerned about this interface since unlabled_t is used for domains
> > and objects.  Someone using this interface might not realize the
> > specified domain can now also read other unlabeled files.
> >
> >   
> The only domain that gets assigned this is sysadm_t.  I believe this was 
> needed in order to kill processes that were in the unlabeled state.  For 
> example if a sysadm unloads a policy file for a running process.  The 
> process goes wild eating up all of cpu, and he can't kill it or even see 
> which process is causing the problem.

I suppose we should turn this into a read unlabeled files interface
instead.  That makes it clear that they can read unlabeled files.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
