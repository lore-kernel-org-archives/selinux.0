Subject: Re: Policy to Allowing another process to only read a UDP port
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Vu, Joseph" <joseph.vu@boeing.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <7790C0F7745DEB4CB90F90914584AAB140D349D6E7@XCH-SW-03V.sw.nos.boeing.com>
References: 
	 <7790C0F7745DEB4CB90F90914584AAB140D349D6E7@XCH-SW-03V.sw.nos.boeing.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Feb 2012 08:26:55 -0500
Message-ID: <1330090015.7650.17.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-02-23 at 14:37 -0800, Vu, Joseph wrote:
> I am trying to create a policy  with a port type. I want to control another process type allowing it to connect to a port and  read only.  No writing is allowed.
> 
> Does the port type has other control beside name_bind?

Not for UDP.  However:
- You can control read/write to self:udp_socket.
- You could use SECMARK to label the packets and control via the :packet
send/recv permissions instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
