Subject: Re: Question of purpose of labeling port numbers?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050223183241.11825.qmail@web51504.mail.yahoo.com>
References: <20050223183241.11825.qmail@web51504.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 13:36:59 -0500
Message-Id: <1109183819.17298.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-23 at 10:32 -0800, Park Lee wrote:
> Hi,
> 
>   We know that in SELinux, TCP and UDP port numbers
> are labeled to permit controls over the ability to
> bind to particular ports. e.g., we can write a rule
> "allow $1 port_t:udp_socket name_bind;" to explain
> this.
> 
>   But, in the definition of macro "can_network" (in
> global_macros.te), we can see the following rule:
> "allow $1 port_type:{ tcp_socket udp_socket } {
> send_msg recv_msg };".
>   Does this rule mean that TCP and UDP port numbers
> are also labeled to permit controls over the ability
> of the socket(i.e. tcp_socket and udp_socket) to send
> or receive messages on particular ports? 

Yes, these controls were introduced in the 2.6 SELinux by James Morris
back in January 2004.  See the mailing list archives.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
