Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GFvkXf022539
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 10:57:46 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GFudlk028925
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 15:56:39 GMT
Subject: Re: sereference: screen policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060113222226.GD26911@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com>
	 <1137168771.29815.211.camel@sgc>
	 <20060113222226.GD26911@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 10:59:06 -0500
Message-Id: <1137427147.29815.232.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-13 at 16:22 -0600, Serge E. Hallyn wrote:
> Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> > On Thu, 2006-01-12 at 15:48 -0600, Serge E. Hallyn wrote:
> > > Still getting the hang of the various existing interfaces, but this
> > > policy at least lets me run screen as sysadm_u and user_u.  This
> > > likely shouldn't go in as is since I doubt it's minimal due to clumsy
> > > use of wrong interfaces, but I won't be looking at this again until
> > > next week at earliest, so meanwhile here's what I've got.
> > 
> > A screen policy was committed two days ago, can you try that one?  I
> > tested it and it seemed to work ok for me.
> 
> Almost but not quite for me.  I needed the following lines added to the
> template:
> 
> 	allow $1_screen_t $1_t:process sigchld;
> 	allow $1_screen_t $1_t:fd use;

Ok, well these should be in there already ($2 == the old $1_t in the
template).

> 	term_setattr_all_user_ptys($1_screen_t)
> 	term_use_all_terms($1_screen_t)

The rule for the user's own terminal should be in.  I don't know if we
should trust screen to use all terminals.

> 	allow $1_screen_t tty_device_t:lnk_file read;

Looks like a mislabeled symlink.  Currently the symlinks in /dev are all
device_t, as far as I know.  Looking at terminal.fc, everything is
marked -c (with the exception of /dev/pts directory which is -d), so I'm
not sure how this would happen.

> Note that I also still need my other patch for local logins from Jan 11.

Ok, I'll go back and look at it.  The response you made to your email
made me think it wasn't actually needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
