Subject: Re: Problems with the MLS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: linda.knippers@hp.com, selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F25F8A25DECDDB93554F5DBAF370@phx.gbl>
References: <BAY114-F25F8A25DECDDB93554F5DBAF370@phx.gbl>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:10:10 -0400
Message-Id: <1157724610.31695.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 12:30 +0200, Salvo Giuffrida wrote:
> I did as you said, but the problems remain: there's no binary policy file in 
> /etc/selinux/mls/policy, and when I go to /etc/selinux/mls/modules/active, 
> and so "semanage -B", it gives me "Segmentation fault".

Please update to the latest devel versions of:
libsepol
libselinux
libsemanage
policycoreutils

Then update to the latest selinux-policy-mls.

> Where can I find more info on the classification system? I'd like to know 
> how the categories are mapped to the TopSecret,Secret,ecc... classification 
> levels...

They are mapped via setrans.conf, in /etc/selinux/mls/setrans.conf.  You
should be able to manage those mappings via semanage, e.g.
run /usr/sbin/semanage translation -l to list the current mappings.

You might want to look at:
http://selinux-symposium.org/2006/papers/03-SELinux-and-MLS.pdf
http://fedoraproject.org/wiki/SELinux/MLS


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
