Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GJmAXf024377
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 14:48:11 -0500 (EST)
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GJl3lk024150
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 19:47:03 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0GJmABM032442
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 14:48:10 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0GJmAmA119818
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 14:48:10 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0GJm9Tr018980
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 14:48:09 -0500
Date: Mon, 16 Jan 2006 13:48:09 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: sereference: screen policy
Message-ID: <20060116194809.GD15246@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com> <1137168771.29815.211.camel@sgc> <20060113222226.GD26911@sergelap.austin.ibm.com> <1137427147.29815.232.camel@sgc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137427147.29815.232.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Fri, 2006-01-13 at 16:22 -0600, Serge E. Hallyn wrote:
> > Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> > > On Thu, 2006-01-12 at 15:48 -0600, Serge E. Hallyn wrote:
> > > > Still getting the hang of the various existing interfaces, but this
> > > > policy at least lets me run screen as sysadm_u and user_u.  This
> > > > likely shouldn't go in as is since I doubt it's minimal due to clumsy
> > > > use of wrong interfaces, but I won't be looking at this again until
> > > > next week at earliest, so meanwhile here's what I've got.
> > > 
> > > A screen policy was committed two days ago, can you try that one?  I
> > > tested it and it seemed to work ok for me.
> > 
> > Almost but not quite for me.  I needed the following lines added to the
> > template:
> > 
> > 	allow $1_screen_t $1_t:process sigchld;
> > 	allow $1_screen_t $1_t:fd use;
> 
> Ok, well these should be in there already ($2 == the old $1_t in the
> template).
> 
> > 	term_setattr_all_user_ptys($1_screen_t)
> > 	term_use_all_terms($1_screen_t)
> 
> The rule for the user's own terminal should be in.  I don't know if we
> should trust screen to use all terminals.
> 
> > 	allow $1_screen_t tty_device_t:lnk_file read;
> 
> Looks like a mislabeled symlink.  Currently the symlinks in /dev are all
> device_t, as far as I know.  Looking at terminal.fc, everything is
> marked -c (with the exception of /dev/pts directory which is -d), so I'm
> not sure how this would happen.

Yup, with /dev/ttyS1 correctly labeled, the existing screen policy works.

(But I still need the rest of my login fix)

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
