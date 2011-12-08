Subject: Re: CIL/SELinux Userspace Integration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Steve Lawrence <slawrence@tresys.com>,
        Richard Haines
 <richard_c_haines@btinternet.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <CACLa4pumnzC-HXMhm2YKEEx3WJBtSYQpejkEJ-tM8Czm1inqaQ@mail.gmail.com>
References: <1322929819.82046.YahooMailClassic@web87016.mail.ird.yahoo.com>
	 <4EDF6AEC.1070606@tresys.com>
	 <CACLa4ptqS=hBZUYDp8bjwnLZeuU8yfprDFi5_dxRRDipT3Xtkg@mail.gmail.com>
	 <4EDF7258.2070800@tresys.com>
	 <CACLa4ptSZ9u6NSe=uiARYZZNA3a1cJAnAyGEy2EGms47_7ak8A@mail.gmail.com>
	 <CACLa4pumnzC-HXMhm2YKEEx3WJBtSYQpejkEJ-tM8Czm1inqaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Dec 2011 08:28:05 -0500
Message-ID: <1323350885.13613.3.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-12-07 at 15:15 -0500, Eric Paris wrote:
> So the problem comes from the code which creates the files in
> /selinux/booleans.  It does an explicit check for a genfs rule for
> selinuxfs to label the new inode.  I'm not certain why we need this
> bit of code.  Maybe it is there to support labeling of individual
> booleans somehow, but I don't see how of why this particular piece of
> code is needed.  In any case I believe (Steve tested but I'm not
> exactly sure what he did) that you can add a genfs statement for
> selinuxfs and it will start working...

Yes, it was to support per-boolean labeling.  However, as you note, lack
of a matching entry for selinuxfs in policy shouldn't be fatal for
policy load, so we should at least ignore ENOENT from
security_genfs_sid() there.  There is a larger issue there however; any
failure in sel_make_bools, sel_make_classes, or sel_make_policycap will
return an error to userspace, causing it to think that the policy load
failed (which triggers an unwind of the transaction by libsemanage,
reverting to the prior policy file), but we have already switched
policies in the kernel as part of security_load_policy().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
