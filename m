Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T900rT029058
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 05:00:00 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T8xwis026605
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 08:59:58 GMT
Date: Sun, 29 Aug 2004 10:11:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: patches for xdm.te for kdm 3.3
Message-ID: <20040829091112.GA7610@lkcl.net>
References: <20040828164528.GC11546@lkcl.net> <200408291721.55576.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408291721.55576.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 29, 2004 at 05:21:55PM +1000, Russell Coker wrote:
> On Sun, 29 Aug 2004 02:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i'm running kdm 3.3, also i'm running an "immediate user login" with no
> > password.
> >
> > added these to get it to work.
> >
> > also as you can see i changed the type of /etc/qt3 to etc_runtime_t.
> 
> file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, { dir fifo_file} )
> 
> This won't work properly due to a limitation of the file_type_trans() macro.  

 urrrr... are you sure?  have there been recent changes [in last month]
 that _stop_ this from working?

> You must have separate lines for "dir" and "fifo_file" (see the attached 
> patch).
> 
> allow xdm_t etc_runtime_t:file { getattr read lock };
> 
> Does it work if you put in a dontaudit rule for lock access?  I don't think it 
> should require lock access.

 i'll try it again: it's been several months.

> allow xdm_t etc_runtime_t:dir { getattr search };
> 
> This is wrong.  There should not be a etc_runtime_t:dir object.  

 it's because this is what i assigned the /etc/qt3 directory to...

> If there is 
> no file_contexts rule for assigning a type to an object and the type in 
> question is not tmpfile then generally you should not include any rules 
> permitting access to the objct.
> 
> # had to change /etc/qt3 to etc_runtime_t too
> 
> The type xdm_rw_etc_t seems appropriate for this

 ... but i'll try this instead.

> allow xdm_t init_t:process { signal };
>        #EXE=/sbin/halt   :  signal
> 
> allow xdm_t xdm_t:capability { sys_boot };
> 
> I think that we need a different domain for this.
 
 that'd be nice.

 oh - this is what i was referring to about "does anyone _use_ kde"
 because the without xdmctl thing (allowing /var/run/xdmctl/* to be
 xdm_var_run_t etc.) and without the above, you can't run "shutdown"
 from the "logout" menu.

> can_exec(xdm_t, xsession_exec_t)
> 
> That looks like a bug.  xsession_exec_t scripts are supposed to execute in 
> user context.  Looks like the kdm patch does not set the execute context 
> everywhere that it should.

 oh.  ah.... that patch.  um.... the one i haven't applied because i
 downloaded kde 3.3 and i thought i could get away with putting in
 pam_selinux.so into /etc/pam.d/kdm because i didn't want to go through
 _yet another_ kdebase-3.x download and build cycle.



> From the current state I expect that it'll be at least another two iterations 
> and some bug reports getting filed before your xdm policy patch is ready to 
> be included.

 oh, i wasn't expecting it to be included because i don't entirely
 know what i'm doing here, i would be happier with pointing out
 things and other people sorting them, but hey ...

 ... so if you're comfortable with doing iterations, like this,
 under such a proviso [me being semi-clueless], then sure.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
