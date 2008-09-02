Subject: Re: user guide draft: "Introduction" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BB3E78.90406@redhat.com>
References: <48B4EAE2.302@redhat.com>
	 <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB3E78.90406@redhat.com>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 08:27:18 -0400
Message-Id: <1220358438.26711.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-01 at 10:59 +1000, Murray McAllister wrote:
> Stephen Smalley wrote:
> 
> [snip]
> 
> >>
> >> -rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1
> >>
> >> In this example, SELinux provides a user (unconfined_u), a role 
> >> (object_r), a type (user_home_t), and a category (s0). 
> 
> Should this be, "...and a level (s0)"?

Yes.  Or a range s0, as a single level is the degenerate case of a range
where the low level and high level are the same.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
