Subject: RE: denial even with appropriate allow rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Thomson, David-P63356" <David.Thomson@gdc4s.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <5E2837B0EB8E1E47850371AE558090B603AFA08B@AZ25EXM03.gddsi.com>
References: <5E2837B0EB8E1E47850371AE558090B603A93BCE@AZ25EXM03.gddsi.com>
	 <1272287226.13393.11.camel@moss-pluto.epoch.ncsc.mil>
	 <5E2837B0EB8E1E47850371AE558090B603AFA08B@AZ25EXM03.gddsi.com>
Content-Type: text/plain
Date: Mon, 26 Apr 2010 15:17:58 -0400
Message-Id: <1272309478.13393.176.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-04-26 at 10:55 -0700, Thomson, David-P63356 wrote:
> It was not a conditional allow rule and I personally retrieved the
> policy file and examined it.
> 
> 
> Turned out it was a constraint that had been put in before either of us
> had touched the policy: 
> 
> constrain tcp_socket { send_msg recv_msg }
> (
> 	t2 != ssh_port_t
>         ...
> );
> 
> 
> In the future I'll remember to check the constraints before I ping you
> guys.  Having a compile time error would have been nice (like for
> neverallows) or if at runtime there was some history of if the "0" in
> the AV permission mask was due to no allow rule being added, or due to a
> constraint clearing the bit.  That could then have been reflected in the
> audit message.  The first option sounds easier.  

audit2why would have at least pointed you to the constraints as the
culprit.

> In the end, this can just be chalked up to "user error" for not checking
> for the policy canceling itself out, but something to help in debugging
> would be nice if it weren't too much of a hassle.  We are working with
> such old policy that maybe you have addressed this already in the newer
> SELinux stuff you churn out.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
