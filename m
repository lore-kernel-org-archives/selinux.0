Subject: Re: problems using setcon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fa8ec5d8050329194145add881@mail.gmail.com>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
	 <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050329194145add881@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 07:35:17 -0500
Message-Id: <1112186117.8012.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-29 at 22:41 -0500, Kodungallur Varma wrote:
> thanx a lot..the program worked. however I need to change the policy
> file(.te) often and so I need to make load it. I am unable to do that
> at the moment due to the problem that I updated the following without
> updating my policy:
> 
> checkpolicy-1.22
> libsepol-1.4
> policycoreutils-1.22
> 
> how do I uninstall them??

You can grab the older checkpolicy, libsepol, and policycoreutils
packages from FC3 and re-install them with rpm -Uvh --oldpackage.

>  also I tried the alternative to update my
> policy by doing:
> "yum install selinux-policy-strict-sources" and "yum install
> selinux-policy-targeted-sources". the targeted version was updated,
> but strict had "nothing to do". seems like it is up to date.

You would need to update to the rawhide (FC4 development) policy; FC3
policy doesn't include these changes.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
