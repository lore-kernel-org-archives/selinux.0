Subject: Re: X server in enforcing x_drawable avcs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <CAFPpqQEfm+xyHWZV=1D1oJbqEvPAinQdu0jYZX+cM_Fo3ESc9w@mail.gmail.com>
References: 
	 <CAFPpqQEfm+xyHWZV=1D1oJbqEvPAinQdu0jYZX+cM_Fo3ESc9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Jan 2012 11:12:58 -0500
Message-ID: <1327939978.23069.12.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-01-24 at 13:27 -0600, Ted Toth wrote:
> I'm seeing x_drawable read denials in Xorg.0.log  on a system with the
> X server in enforcing. I'm confused about these because the
> xserver_object_manager boolean is set which gets:
> allow x_domain xdrawable_type:x_drawable *;
> 
> and the source context type of the avc is a type in the x_domain
> attribute and the target context type is in the xdrawable_type
> attribute which should be allowed by the included allow rule.

Have you checked whether compute_av (from libselinux/utils) gives the
expected result?

What does audit2why aka audit2allow -w say about the denial?
Could it be a constraint violation instead of a TE denial?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
