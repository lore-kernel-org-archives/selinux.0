Subject: Re: [ SEPOL ] [ SEMANAGE ] Debug v3, some database things
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <434E3D75.8060009@cornell.edu>
References: <434CC592.70001@cornell.edu>
	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>
	 <434D35B1.7060409@cornell.edu>
	 <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>
	 <434D3D33.90104@cornell.edu> <434E38C2.9030602@cornell.edu>
	 <434E3D75.8060009@cornell.edu>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 08:34:33 -0400
Message-Id: <1129206873.26188.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 06:56 -0400, Ivan Gyurdiev wrote:
> Bugfix:
> Can you please add ( ) around every dereference of handle_arg in 
> msg_write (for both semanage and sepol)
> I can send a followup patch if you prefer. Macros are evil...
> 
> Warning:
> The following code is no longer valid - this is now a syntax error.
> if (blah) DEBUG(a); else ..

Wrap the definition with 
do {

} while (0)

and you'll be fine.

That's a widely used trick in the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
