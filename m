Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA52N0XZ029674
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 21:23:02 -0500 (EST)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA52Lc8f007249
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 02:21:38 GMT
Received: by rproxy.gmail.com with SMTP id i8so1073rne
        for <selinux@tycho.nsa.gov>; Thu, 04 Nov 2004 18:23:00 -0800 (PST)
Message-ID: <46ce702f041104182352cbcd1@mail.gmail.com>
Date: Thu, 4 Nov 2004 20:23:00 -0600
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: learning about policies/transitions
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Addendum:  running setfilecon works once.  After each reboot, I must again run
setfilecon.before /bin/login will cause the transition to login_d. 
Again, running
/bin/ls -Z /bin/login shows no difference before and after the
setifilecon - it is always
of type login_et.

At this point, I suppose I should just switch to the latest fedora deverlopment
release and see whether this problem magically resolves itself.  If
not, I guess some
debug info at d_instantiate will be order.

thanks,
-serge

On Thu, 04 Nov 2004 12:11:06 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Thu, 2004-11-04 at 11:20, Serge Hallyn wrote:
> > Ah, running setfilecon worked.
> >
> > I don't understand why, though.  The security.selinux xattr (as given by
> > getxattr(2)) looked the same before and after.  What else is being changed
> > by setfilecon?
> 
> The incore inode SID.  setfilecon(1) unconditionally calls
> setfilecon(3), which invokes setxattr(2), which will invoke the
> post_setxattr hook and update the incore inode SID.  setfiles and/or
> chcon would have just looked at the existing on-disk xattr value (via
> getfilecon(3)->getxattr(2)), seen that the on-disk xattr was already
> correct, and not bothered to call setfilecon(3), so the incore inode SID
> wasn't being updated by those programs.  I think RedHat is/has added an
> option to chcon(1) to force the call to setfilecon(3) regardless of its
> current value.  Perhaps setfiles(1) should unconditionally call
> setfilecon(3) too.
> 
> This is an unfortunate side effect of using the xattr API (vs. the
> original SELinux API, which directly fetched the incore inode SID and
> returned it to the caller), because the xattr API always consults the
> filesystem and reports the on-disk xattr.  SELinux maps the on-disk
> xattr to a SID at the time of d_instantiate, but if the on-disk xattr is
> invalid at that time (e.g. type isn't defined in the policy), then the
> inode SID is left unlabeled and it requires an explicit setxattr(2) to
> correct.
> 
> --
> 
> 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
