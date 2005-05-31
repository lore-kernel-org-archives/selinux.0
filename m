Subject: RE: file_type_auto_trans is not sufficient
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
	 <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 13:07:03 -0400
Message-Id: <1117559223.28924.202.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 12:48 -0400, Ivan Gyurdiev wrote:
> I am not following this - can you give an example.
> 
> Say you have an application such as gconf, which stores its data 
> in /tmp/gconfd-$USER (so it needs to be able to create that). 
> GConf is linked to libORBit2, hence it needs to be able to
> create /tmp/orbit-$USER.
> 
> Running gconfd in an individual domain is possible (and that's exactly
> what I've done). Running orbit in its domain does not work (at least not
> without a dynamic transition), because it's library code.
> 
> Are you saying that either gconfd or orbit need to move their files
> outside their designated directory and into /tmp?

Problem is that they both want to create directly in /tmp.  It would be
preferable if they had a dedicated subtree, e.g. /tmp/gconfd
and /tmp/orbit, with all per-user subdirectories underneath, so that the
top-level directory could be typed separately and set up a priori (at
boot if truly under /tmp, as they might otherwise have been deleted).
BTW, what will per-user /tmp directories due to these conventions
anyway, even aside from any possible SELinux-related change?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
