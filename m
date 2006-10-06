Message-ID: <45268B5B.7080709@mentalrootkit.com>
Date: Fri, 06 Oct 2006 12:59:07 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: Denials from newest kernel
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>	 <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>	 <1160149463.2905.5.camel@twoface.columbia.tresys.com> <1160150179.12253.127.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160150179.12253.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-10-06 at 11:44 -0400, Joshua Brindle wrote:
>   
>
> But in the case where an object inherits the label of another object,
> that is to be expected - we will end up seeing "packets" with the labels
> of associations, which in turn are labels of sockets, which in turn are
> (usually) labels of processes.  No need to turn every check on a
> "packet" into a check on some original class from which its label was
> derived.
>
>   

Agreed.
> Also, the above isn't true of all checks, e.g.
> 	allow ftpd_t ftp_port_t:tcp_socket name_bind;
>
>   

For what its worth I always found that the overloading of the socket 
objects for port checks to be very confusing and difficult to explain.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
