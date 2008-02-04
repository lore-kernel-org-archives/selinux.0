Subject: Re: su problems again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202157694.2801.128.camel@bluejay.goodinassociates.com>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
	 <1202154013.2801.119.camel@bluejay.goodinassociates.com>
	 <1202155858.3070.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1202156505.2801.122.camel@bluejay.goodinassociates.com>
	 <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1202157694.2801.128.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 15:52:41 -0500
Message-Id: <1202158361.3070.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 14:41 -0600, Jeremiah Jahn wrote:
> Any idea what this is about?
> 
> policy/modules/system/mount.te:18:ERROR 'syntax error' at token
> 'typeattribute' on line 844559:
> 
> This is the third one I've gotten. I got the same error for mono and
> monop. This is why I didn't just change the build.conf file. I seem to
> be able to move on to the next on if I set this back to module instead
> of base, but this seems to not seem right to me. 

Yes, sounds like a bug in the policy.  Surrounding context from that
line might be useful, although I'm sure Chris can reproduce easily
enough just by trying a build that puts everything into base.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
