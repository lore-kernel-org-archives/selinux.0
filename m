MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: denial even with appropriate allow rules
Date: Mon, 26 Apr 2010 10:55:56 -0700
Message-ID: <5E2837B0EB8E1E47850371AE558090B603AFA08B@AZ25EXM03.gddsi.com>
In-Reply-To: <1272287226.13393.11.camel@moss-pluto.epoch.ncsc.mil>
References: <5E2837B0EB8E1E47850371AE558090B603A93BCE@AZ25EXM03.gddsi.com> <1272287226.13393.11.camel@moss-pluto.epoch.ncsc.mil>
From: "Thomson, David-P63356" <David.Thomson@gdc4s.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It was not a conditional allow rule and I personally retrieved the
policy file and examined it.


Turned out it was a constraint that had been put in before either of us
had touched the policy: 

constrain tcp_socket { send_msg recv_msg }
(
	t2 != ssh_port_t
        ...
);


In the future I'll remember to check the constraints before I ping you
guys.  Having a compile time error would have been nice (like for
neverallows) or if at runtime there was some history of if the "0" in
the AV permission mask was due to no allow rule being added, or due to a
constraint clearing the bit.  That could then have been reflected in the
audit message.  The first option sounds easier.  

In the end, this can just be chalked up to "user error" for not checking
for the policy canceling itself out, but something to help in debugging
would be nice if it weren't too much of a hassle.  We are working with
such old policy that maybe you have addressed this already in the newer
SELinux stuff you churn out.  

Thanks again!



-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Monday, April 26, 2010 6:07 AM
To: Thomson, David-P63356
Cc: SELinux@tycho.nsa.gov
Subject: Re: denial even with appropriate allow rules

On Fri, 2010-04-23 at 14:49 -0700, Thomson, David-P63356 wrote:
> I'm helping a co-worker with a policy problem.  In permissive he gets
a
> couple denials:
> 
> type=AVC msg=audit(1272049866.598:32539): avc:  denied  { send_msg }
for
> saddr=192.168.99.128 src=32786 daddr=192.168.99.1 dest=22 netif=eth0
> scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:ssh_port_t
> tclass=tcp_socket
> 
> type=AVC msg=audit(1272049866.598:32540): avc:  denied  { recv_msg }
for
> saddr=192.168.99.1 src=22 daddr=192.168.99.128 dest=32786 netif=eth0
> scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:ssh_port_t
> tclass=tcp_socket
> 
> I've checked his source policy and even checked the policy.18 file on
> his target machine, they both show:
> 
> Allow sshd_t ssh_port_t : tcp_socket { recv_msg send_msg ... };
> 
> The only time I've seen it ignore networking policy was when I was
doing
> it the old (pre-secmark) way but forgot to put selinux_compat_net=1 on
> the kernel line.  His kernel version is 2.6.9 so this should predate
> secmark and need no flag, correct?  There is no /selinux/compat_net
file
> on the machine so I assume it should just work.
> 
> This is a fairly old and well "customized" policy, if that matters.  
> 
> 
> Any ideas?

Is the allow rule conditional (within an if statement) or unconditional?

Are you sure the policy file you are examining is the one that was
loaded into the kernel?

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
