Subject: Re: newrole authentication
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0236CA79@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0236CA79@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:55:30 -0400
Message-Id: <1192535730.8702.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-15 at 16:12 -0700, Clarkson, Mike R (US SSA) wrote:
> Will someone point me to information or send me an example on how to set
> up newrole so that is does not ask for a password, so that it can by
> used like this within software "newrole -l s1 -- -c <cmd>"?

You need policycoreutils 2.0.19 or later, or you need to back port that
change to whatever newrole you have.

See:
http://marc.info/?t=117769973100008&r=1&w=2
http://marc.info/?l=selinux&m=117865153827263&w=2

Then you can set up a /etc/selinux/newrole_pam.conf file with e.g.:
/path/to/cmd newrole-noauth
and you can set up a /etc/pam.d/newrole-noauth file with pam_permit.so
as the auth module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
